import Foundation
import Network

@available(iOS 14.0, *)
class LocalNetworkAuthorization: NSObject {

      private var browser: NWBrowser?
      private var netService: NetService?
      private var completion: ((Bool) -> Void)?
      
      public func requestAuthorization(completion: @escaping (Bool) -> Void) {
          self.completion = completion
          
          // Create parameters, and allow browsing over peer-to-peer link.
          let parameters = NWParameters()
          parameters.includePeerToPeer = true
          
          // Browse for a custom service type.
          let browser = NWBrowser(for: .bonjour(type: "_bonjour._tcp", domain: nil), using: parameters)
          print("Hello-----requestAuthorization")
          self.browser = browser
          browser.stateUpdateHandler = { newState in
              print("Hello-----newState", newState)
              switch newState {
              case .failed(let error):
                  print(error.localizedDescription)
              case .ready, .cancelled:
                  break
              case let .waiting(error):
                  print("Local network permission has been denied: \(error)")
                  self.reset()
                  self.completion?(false)
              default:
                  break
              }
          }
          
          print("Hello-----requestAuthorization2222222")
          self.netService = NetService(domain: "local.", type:"_lnp._tcp.", name: "LocalNetworkPrivacy", port: 1100)
          self.netService?.delegate = self
          
          self.browser?.start(queue: .main)
          self.netService?.publish()
          // the netService needs to be scheduled on a run loop, in this case the main runloop
          self.netService?.schedule(in: .main, forMode: .common)
          print("Hello-----requestAuthorization33333333")
      }
      
      private func reset() {
          print("resetting")
          self.browser?.cancel()
          self.browser = nil
          self.netService?.stop()
          self.netService = nil
      }
}

@available(iOS 14.0, *)
extension LocalNetworkAuthorization : NetServiceDelegate {
    public func netServiceDidPublish(_ sender: NetService) {
        self.reset()
        print("Local network permission has been granted")
        completion?(true)
    }
}