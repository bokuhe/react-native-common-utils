import Foundation
import UIKit
import React

@objc private protocol PrivateSelectors: NSObjectProtocol {
    var destinations: [NSNumber] { get }
    func sendResponseForDestination(_ destination: NSNumber)
}

@objc(AppNavigator)
class AppNavigator: NSObject, RCTBridgeModule {
  static func moduleName() -> String {
    return "AppNavigator"
  }

  @objc func backToPreviousApp(_ resolver: RCTPromiseResolveBlock,
                               rejecter: RCTPromiseRejectBlock) {
      guard
          let sysNavIvar = class_getInstanceVariable(UIApplication.self, "_systemNavigationAction"),
          let action = object_getIvar(UIApplication.shared, sysNavIvar) as? NSObject,
          let destinations = action.perform(#selector(getter: PrivateSelectors.destinations))?.takeUnretainedValue() as? [NSNumber],
          let firstDestination = destinations.first
      else {
          rejecter("NO_NAVIGATION_ACTION", "System navigation action or destination not found.", nil)
          return
      }

      action.perform(#selector(PrivateSelectors.sendResponseForDestination), with: firstDestination)
      resolver(nil)
  }

  @objc func exitApp(_ resolver: RCTPromiseResolveBlock,
                     rejecter: RCTPromiseRejectBlock) {
    DispatchQueue.main.async {
      UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        exit(0)
      }
    }
    resolver(nil)
  }
}
