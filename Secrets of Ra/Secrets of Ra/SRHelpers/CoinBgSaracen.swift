import SwiftUI

struct CoinBgSaracen: View {
    @StateObject var user = UserSaracen.shared
    var body: some View {
        ZStack {
            Image(.moneyViewBgSaracen)
                .resizable()
                .scaledToFit()
            
            Text("\(user.money)")
                .font(.system(size: SaracenDeviceInfo.shared.deviceType == .pad ? 40:20, weight: .black))
                .foregroundStyle(.white)
                .textCase(.uppercase)
                .offset(x: SaracenDeviceInfo.shared.deviceType == .pad ? 50:25, y: SaracenDeviceInfo.shared.deviceType == .pad ? 2:1)
            
            
            
        }.frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 100:50)
        
    }
}

#Preview {
    CoinBgSaracen()
}
