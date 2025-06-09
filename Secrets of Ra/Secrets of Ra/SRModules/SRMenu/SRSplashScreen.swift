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
                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 400:400)
                .padding(.top, SaracenDeviceInfo.shared.deviceType == .pad ? 100:70)
                
                Image(.subtitleImgSR)
                    .resizable()
                    .scaledToFit()
                    .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 164:82)
                    .padding(.vertical, 50)
                
               
                TextWithBorderSaracen(text: "\(Int(progress))%", font: .system(size: 39, weight: .regular), textColor: .white, borderColor: .bordovyi, borderWidth: 1)
                
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
            if progress < 100 {
                progress += 1
            } else {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    SRSplashScreen()
}
