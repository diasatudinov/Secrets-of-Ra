//
//  SettingsViewModelSG.swift
//  Secrets of Ra
//
//  Created by Dias Atudinov on 09.06.2025.
//


import SwiftUI

class SettingsViewModelSG: ObservableObject {
    @AppStorage("musicEnabled") var musicEnabled: Bool = true
    @AppStorage("soundEnabled") var soundEnabled: Bool = true
    @AppStorage("vibraEnabled") var vibraEnabled: Bool = true
}