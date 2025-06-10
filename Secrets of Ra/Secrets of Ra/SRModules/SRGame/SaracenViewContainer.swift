//
//  SaracenViewContainer.swift
//  Secrets of Ra
//
//  Created by Dias Atudinov on 10.06.2025.
//


import SwiftUI
import SpriteKit


struct SaracenViewContainer: UIViewRepresentable {
    @StateObject var user = UserSaracen.shared
    var scene: GameScene
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
