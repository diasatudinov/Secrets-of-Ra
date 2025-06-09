//
//  CoinBgSaracen.swift
//  Secrets of Ra
//
//  Created by Dias Atudinov on 09.06.2025.
//


import SwiftUI

struct CoinBgSaracen: View {
    @StateObject var user = UserSaracen.shared
    var body: some View {
        ZStack {
            Image(.moneyViewBgSR)
                .resizable()
                .scaledToFit()
            
            Text("\(user.money)")
                .font(.system(size: SaracenDeviceInfo.shared.deviceType == .pad ? 40:20, weight: .black))
                .foregroundStyle(.white)
                .textCase(.uppercase)
                .offset(x: SaracenDeviceInfo.shared.deviceType == .pad ? 10:5, y: SaracenDeviceInfo.shared.deviceType == .pad ? 0:0)
            
            
            
        }.frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 100:50)
        
    }
}

#Preview {
    CoinBgSaracen()
}
