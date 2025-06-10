//
//  SettingsViewModelSG.swift
//  Secrets of Ra
//
//


import SwiftUI

class SettingsViewModelSG: ObservableObject {
    @AppStorage("musicEnabled") var musicEnabled: Bool = true
    @AppStorage("soundEnabled") var soundEnabled: Bool = true
}
