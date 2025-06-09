//
//  SRSplashScreen.swift
//  Secrets of Ra
//
//

import SwiftUI

struct SRSplashScreen: View {
    @State private var scale: CGFloat = 1.0
    @State private var progress: CGFloat = 0.0
    @State private var timer: Timer?
    private var loaderWidth: CGFloat = {
       return SaracenDeviceInfo.shared.deviceType == .pad ? 500:250
    }()
    var body: some View {
        ZStack {
            Image(.gameBgSR)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {

                ZStack {
                    Image(.logoIconSR)
                        .resizable()
                        .scaledToFit()
                    
                    
                }
                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 400:200)
                .padding(.top, SaracenDeviceInfo.shared.deviceType == .pad ? 100:70)
                
                Image(.subtitleImgSR)
                    .resizable()
                    .scaledToFit()
                    .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 164:82)
                    .padding(.top, 100)
                
               
                
//                ZStack {
//                   
//                    Image(.loaderIconSG)
//                        .resizable()
//                        .scaledToFit()
//                        .colorMultiply(.gray)
//                    
//                    Image(.loaderIconSG)
//                        .resizable()
//                        .scaledToFit()
//                        .mask(
//                            Rectangle()
//                                .frame(width: progress * loaderWidth)
//                                .padding(.trailing, (1 - progress) * loaderWidth)
//                        )
//                    
//                }
//                .frame(width: SaracenDeviceInfo.shared.deviceType == .pad ? 500:250)
//                .padding(.top, 90)
                Spacer()
            }
            
            
        }
        .onAppear {
            startTimer()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 1 {
                progress += 0.01
            } else {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    SRSplashScreen()
}
