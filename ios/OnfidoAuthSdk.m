#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(OnfidoAuthSdk, NSObject)

RCT_EXTERN_METHOD(
  start:(NSDictionary *)config
  resolver:(RCTPromiseResolveBlock)resolve
  rejecter:(RCTPromiseRejectBlock)reject
)

@end
