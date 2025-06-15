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
    var backBtnHandle: (() -> ())
    @State private var gameWon = false
   
    
    @State var gameScene: SRGameScene = {
        
        let scene = SRGameScene(size: UIScreen.main.bounds.size)
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
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 120:70)
                        
                        Image(.chest1SR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 120:70)
                        Spacer()
                        Image(.chest1SR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 120:70)
                        
                        Image(.chest1SR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 120:70)
                    }
                }.ignoresSafeArea()
                VStack {
                    HStack(alignment: .top) {
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            backBtnHandle()
                        } label: {
                            Image(.backIconSR)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 100:50)
                        }
                        
                        
                        Spacer()
                        Image(.backIconSR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 100:50)
                            .opacity(0)
                    }.padding([.top, .horizontal])
                    
                    SRViewContainer(scene: gameScene, level: level)
                        .ignoresSafeArea(edges: .bottom)
                        
                }
                
                if gameWon {
                    Color.black.opacity(0.5).ignoresSafeArea()
                    VStack(spacing: 50) {
                        Image(.winTextSR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 250:150)
                        
                        
                        Image(.priceHundredSR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 100:50)
                        
                        VStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(.continueTextSR)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 200:100)
                            }
                            
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(.menuTextSR)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 200:100)
                            }
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
                UserSR.shared.updateUserMoney(for: 100)
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
    SRGameView(level: 1, backBtnHandle: { })
}

extension Notification.Name {
    static let gameWon = Notification.Name("gameWon")
}
