package com.reactnativeonfidoauthsdk

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.BaseActivityEventListener
import com.facebook.react.bridge.ActivityEventListener
import com.onfido.authentication.contract.OnfidoAuthentication
import com.onfido.authentication.contract.OnfidoAuthenticationConfig
import com.onfido.authentication.contract.OnfidoAuthenticationImpl
import android.app.Activity
import android.content.Intent
import java.lang.Exception

class OnfidoAuthSdkModule: ReactContextBaseJavaModule {

  companion object {
    private const val ONFIDO_AUTH_REQUEST_CODE = 300
  }

  private lateinit var onfidoAuth: OnfidoAuthentication
  private var currentPromise: Promise? = null

  private fun setPromise(promise: Promise) {
    if (currentPromise != null) {
      currentPromise?.reject("error", Exception("New activity was started before old promise was resolved."))
    }
    currentPromise = promise
  }

  private fun getSdkTokenFromConfig(config: ReadableMap): String {
    return config.getString("sdkToken") ?: ""
  }

  private fun getRetryCountFromConfig(config: ReadableMap): Int {
    if (config.hasKey("retryCount")) {
      return config.getInt("retryCount")
    }
    return 0
  }

  private fun getCurrentActivityInParentClass(): Activity? {
    return super.getCurrentActivity()
  }

  override fun getName(): String {
    return "OnfidoAuthSdk"
  }

  private val mActivityEventListener: ActivityEventListener = object : BaseActivityEventListener() {
    override fun onActivityResult(activity: Activity, requestCode: Int, resultCode: Int, data: Intent?) {
      super.onActivityResult(requestCode, resultCode, data)

      if (requestCode == ONFIDO_AUTH_REQUEST_CODE) {
        onfidoAuth.handleActivityResult(
          resultCode,
          data,
          object : OnfidoAuthentication.ResultListener {
            override fun onUserCompleted(authResult: OnfidoAuthentication.AuthenticationResult) {
              currentPromise?.resolve(authResult)
              currentPromise = null
            }

            override fun onUserExited(exitCode: OnfidoAuthentication.ExitCode) {
              when(exitCode) {
                OnfidoAuthentication.ExitCode.CAMERA_PERMISSION_DENIED -> {
                  currentPromise?.reject("deniedPermission", "User denied permission to use camera.")
                  currentPromise = null
                }
                OnfidoAuthentication.ExitCode.USER_CONSENT_DENIED -> {
                  currentPromise?.reject("deniedConsent", "User denied consent.")
                  currentPromise = null
                }
                OnfidoAuthentication.ExitCode.USER_CANCELLED -> {
                  currentPromise?.reject("userExit", "User canceled flow.")
                  currentPromise = null
                }
                else -> {
                  currentPromise?.reject("userExit", "User canceled flow via unknown method.")
                  currentPromise = null
                }
              }
            }

            override fun onError(exception: OnfidoAuthentication.AuthException) {
              currentPromise?.reject("error", "Encountered an error running the flow.", exception)
              currentPromise = null
            }
          })
      }
    }
  }

  constructor(reactContext: ReactApplicationContext): super(reactContext) {
    reactContext.addActivityEventListener(mActivityEventListener)
  }

  @ReactMethod
  public fun start(config: ReadableMap, promise: Promise) {

    setPromise(promise);

    try {
      var sdkToken: String
      val retryCount: Int

      try {
        sdkToken = getSdkTokenFromConfig(config)
        retryCount = getRetryCountFromConfig(config)
      } catch (e: Exception) {
        currentPromise?.reject("configError", e)
        currentPromise = null
        return
      }

      val currentActivity = getCurrentActivityInParentClass()
      if (currentActivity == null) {
        currentPromise?.reject("error", "Android activity does not exist.")
        currentPromise = null
        return
      }

      val onfidoAuthConfigBuilder: OnfidoAuthenticationConfig.Builder = OnfidoAuthenticationConfig.builder(currentActivity)
        .withSdkToken(sdkToken)

      if (retryCount > 0) {
        onfidoAuthConfigBuilder.withRetryCount(retryCount)
      }

      val builtOnfidoAuthConfig = onfidoAuthConfigBuilder.build()

      onfidoAuth = OnfidoAuthenticationImpl(currentActivity)
      onfidoAuth.startActivityForResult(
        currentActivity,
        ONFIDO_AUTH_REQUEST_CODE,
        builtOnfidoAuthConfig
      )
    } catch (error: Exception) {
      currentPromise?.reject("error", "Unexpected error starting Onfido Auth page.", error)
      currentPromise = null;
      return;
    }
  }

}
