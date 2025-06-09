import UIKit

class SaracenDeviceInfo {
    static let shared = SaracenDeviceInfo()
    
    var deviceType: UIUserInterfaceIdiom
    
    private init() {
        self.deviceType = UIDevice.current.userInterfaceIdiom
    }
}
