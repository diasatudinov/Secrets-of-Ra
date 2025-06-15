//
//  SaracenViewContainer.swift
//  Secrets of Ra
//
//


import SwiftUI
import SpriteKit


struct SRViewContainer: UIViewRepresentable {
    @StateObject var user = UserSR.shared
    var scene: SRGameScene
    var level: Int
    
    func makeUIView(context: Context) -> SKView {
        let skView = SKView(frame: UIScreen.main.bounds)
        skView.backgroundColor = .clear
        scene.scaleMode = .resizeFill
        scene.currentLevel = level
        skView.presentScene(scene)
        
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        uiView.frame = UIScreen.main.bounds
    }
}
