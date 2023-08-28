#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(AppNavigator, NSObject)

+ (BOOL)requiresMainQueueSetup
{
  return false;  // only do this if your module initialization relies on calling UIKit!
}

RCT_EXTERN_METHOD(backToPreviousApp: (RCTPromiseResolveBlock)resolver rejecter: (RCTPromiseRejectBlock)rejecter)

RCT_EXTERN_METHOD(exitApp: (RCTPromiseResolveBlock)resolver rejecter: (RCTPromiseRejectBlock)rejecter)

@end
