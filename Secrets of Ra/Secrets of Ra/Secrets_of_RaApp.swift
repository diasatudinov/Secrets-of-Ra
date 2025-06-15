//
//  Secrets_of_RaApp.swift
//  Secrets of Ra
//
//

import SwiftUI

@main
struct Secrets_of_RaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            SRRoot()
                .preferredColorScheme(.light)
        }
    }
}
