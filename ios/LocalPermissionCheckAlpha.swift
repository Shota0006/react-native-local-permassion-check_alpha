@objc(LocalPermissionCheckAlpha)
class LocalPermissionCheckAlpha: NSObject {

  static func moduleName() -> String! {
      return "LocalPermissionCheckAlpha"
  }

  @objc
  func check(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) {

        if #available(iOS 14.0, *) {
            print("ddddddcheck=-========")
            let authorizationInstance = LocalNetworkAuthorization()
            
            print("check=-========")
            authorizationInstance.requestAuthorization { isAuthorized in
                if isAuthorized {
                    print("check=-========1111")
                    resolve(true)
                } else {
                    print("check=-========22222")
                    resolve(false)
                }
            }
        } else {
            // if iOS is lower than 14.0, no local network permission is needed and we always return true
            resolve(true)
        }
    }
}
