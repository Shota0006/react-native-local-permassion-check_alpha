#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(LocalPermissionCheckAlpha, NSObject)

RCT_EXTERN_METHOD(check: (RCTPromiseResolveBlock)resolve rejecter: (RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
