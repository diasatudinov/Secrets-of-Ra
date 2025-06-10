//
//  SRGameView.swift
//  Secrets of Ra
//
//

import SwiftUI
import SpriteKit

struct SRGameView: View {
    @Environment(\.presentationMode) var presentationMode

    let level: Int
    @State private var gameWon = false
   
    
    @State var gameScene: GameScene = {
        
        let scene = GameScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .resizeFill
        return scene
    }()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Image(.chest1SR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 120:70)
                        
                        Image(.chest1SR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 120:70)
                        Spacer()
                        Image(.chest1SR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 120:70)
                        
                        Image(.chest1SR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 120:70)
                    }
                }.ignoresSafeArea()
                VStack {
                    HStack(alignment: .top) {
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(.backIconSR)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 100:50)
                        }
                        
                        
                        Spacer()
                        Image(.backIconSR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 100:50)
                            .opacity(0)
                    }.padding([.top, .horizontal])
                    
                    SaracenViewContainer(scene: gameScene, level: level)
                        .ignoresSafeArea(edges: .bottom)
                        
                }
                if gameWon {
                    VStack {
                        Text("Победа!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                            .shadow(radius: 10)
                        Button(action: restartGame) {
                            Text("Играть заново")
                                .font(.headline)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 12)
                                .background(Color.blue.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                
            }.background(
                ZStack {
                    Image(.gameViewBgSR)
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFill()
                }
            )
            .onReceive(NotificationCenter.default.publisher(for: .gameWon)) { _ in
                gameWon = true
            }
        }
    }
    
    private func restartGame() {
        // Reset flag
        gameWon = false
        gameScene.restart()
    }
    
}

#Preview {
    SRGameView(level: 1)
}

extension Notification.Name {
    static let gameWon = Notification.Name("gameWon")
}
