//
//  SaracenDeviceInfo.swift
//  Secrets of Ra
//
//  Created by Dias Atudinov on 09.06.2025.
//


import UIKit

class SaracenDeviceInfo {
    static let shared = SaracenDeviceInfo()
    
    var deviceType: UIUserInterfaceIdiom
    
    private init() {
        self.deviceType = UIDevice.current.userInterfaceIdiom
    }
}
