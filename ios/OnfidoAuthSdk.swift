import Foundation
#if !targetEnvironment(simulator)
import OnfidoAuth


public func buildOnfidoAuthConfig(config:NSDictionary) throws -> OnfidoAuth.OnfidoAuthConfigBuilder {
  let sdkToken:String = config["sdkToken"] as! String

  var onfidoAuthConfig = OnfidoAuthConfig.builder()
    .withSDKToken(sdkToken)

  if let retryCount = (config["retryCount"] as? Int) {
    onfidoAuthConfig = onfidoAuthConfig.withRetryCount(retryCount)
  }

  return onfidoAuthConfig;
}

@objc(OnfidoAuthSdk)
class OnfidoAuthSdk: NSObject {

  private lazy var rootViewController = UIApplication.shared.windows.first?.rootViewController?.findTopMostController()

  @objc static func requiresMainQueueSetup() -> Bool {
    return false
  }

  @objc func start(_ config: NSDictionary,
                    resolver resolve: @escaping RCTPromiseResolveBlock,
                    rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    DispatchQueue.main.async {
      self.run(withConfig: config, resolver: resolve, rejecter: reject)
    }
  }

  private func run(withConfig config: NSDictionary,
                  resolver resolve: @escaping RCTPromiseResolveBlock,
                  rejecter reject: @escaping RCTPromiseRejectBlock) {

    do {
      let responseHandler: (OnfidoAuthResponse) -> Void = { response in
        switch response {
          case let .success(results):
            resolve(results)
            return;
          case let .cancel(reason):
            switch (reason) {
              case .deniedConsent:
                reject("deniedConsent", "User denied consent.", nil)
              case .openedInLandscape:
                reject("openedInLandscape", "Face scan in landscape orientation.", nil)
              case .openedInReversePortrait:
                reject("openedInLandscape", "Face scan upside down.", nil)
              case .userExited:
                reject("userExit", "User canceled flow.", nil)
              default:
                reject("userExit", "User canceled flow via unknown method.", nil)
            }
            return;
          case let .error(error):
            switch error {
              case OnfidoAuthFlowError.cameraPermissionDenied:
                reject("\(error)", "User denied permission to use camera.", error)
              case OnfidoAuthFlowError.sessionCreationUnsuccessful:
                reject("\(error)", "Failed to create face scan session.", error)
              case OnfidoAuthFlowError.api(let error):
                reject("\(error)", "Received error from API call.", error)
              case OnfidoAuthFlowError.exception(let error):
                reject("\(String(describing: error))", "Unexpected error.", error)
              default:
                reject("\(error)", "Encountered an error running the flow.", error)
            }
            return;
          default:
            reject("error", "Unknown error has occurred.", nil)
            return;
        }
      }

      let onfidoAuthConfig =  try buildOnfidoAuthConfig(config: config)
      let builtOnfidoAuthConfig = try onfidoAuthConfig.build()

      let onfidoAuthFlow = OnfidoAuthFlow(withConfiguration: builtOnfidoAuthConfig)
        .with(responseHandler: responseHandler)

      if let rootViewController = self.rootViewController {
        onfidoAuthFlow.run(from: rootViewController)
      } else {
        reject("error", "Error running Onfido auth flow.", nil)
        return;
      }

    } catch let error as NSError {
      reject("\(error)", error.domain, error)
      return
    } catch let error {
      reject("\(error)", "Error running Onfido SDK.", error)
      return;
    }
  }

}
#else
@objc(OnfidoAuthSdk)
class OnfidoAuthSdk: NSObject {

  private lazy var rootViewController = UIApplication.shared.windows.first?.rootViewController?.findTopMostController()

  @objc static func requiresMainQueueSetup() -> Bool {
    return false
  }

  @objc func start(_ config: NSDictionary,
                    resolver resolve: @escaping RCTPromiseResolveBlock,
                    rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    DispatchQueue.main.async {
      self.run(withConfig: config, resolver: resolve, rejecter: reject)
    }
  }

  private func run(withConfig config: NSDictionary,
                  resolver resolve: @escaping RCTPromiseResolveBlock,
                  rejecter reject: @escaping RCTPromiseRejectBlock) {
      resolve("Simulator");
      return;
  }

}
#endif

extension UIViewController {
  public func findTopMostController() -> UIViewController {
    var topController: UIViewController? = self
    while topController!.presentedViewController != nil {
      topController = topController!.presentedViewController!
    }
    return topController!
  }
}
