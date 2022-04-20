package com.reactnativeonfidoauthsdk

import com.facebook.react.bridge.Arguments
import com.onfido.authentication.contract.OnfidoAuthentication
import com.facebook.react.bridge.WritableMap

/**
 * The response object represents the results of a successful execution of the Onfido Auth SDK.
 */
class Response(private val authResult: OnfidoAuthentication.AuthenticationResult) {
  fun convertToWritableMap(): WritableMap {
    val responseMap = Arguments.createMap()
    responseMap.putString("token", authResult.token)
    responseMap.putString("uuid", authResult.uuid)
    responseMap.putBoolean("verified", authResult.verified)
    return responseMap
  }
}
