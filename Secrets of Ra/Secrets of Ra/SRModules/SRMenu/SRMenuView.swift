//
//  SRMenuView.swift
//  Secrets of Ra
//
//

import SwiftUI

struct SRMenuView: View {
    @State private var showGame = false
    @State private var showAchievement = false
    @State private var showAbility = false
    @State private var showSettings = false
    @State private var showDailyTask = false

    
    @StateObject var achievementVM = SRAchievementsViewModel()
    @StateObject var settingsVM = SettingsViewModelSR()
    @StateObject var shopVM = SRAbilitiesViewModel()
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
                HStack(alignment: .top) {
                    Image(.settingsIconSR)
                        .resizable()
                        .scaledToFit()
                        .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 130:65)
                        .opacity(0)
                    
                    Spacer()
                    
                    CoinBgSR()
                    
                    Spacer()
                    
                    Button {
                        showSettings = true
                    } label: {
                        Image(.settingsIconSR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 130:65)
                    }
                    
                }
                
                Image(.logoIconSR)
                    .resizable()
                    .scaledToFit()
                    .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 320:160)
                
                VStack(spacing:0) {
                    Button {
                        showGame = true
                        
                    } label: {
                        
                        ZStack {
                            Image(.levelsIconSR)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 210:150)
                            
                            
                                
                        }
                    }
                    
                    
                    Button {
                        showAbility = true
                    } label: {
                        ZStack {
                            Image(.abilityIconSR)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 180:100)
                            
                            
                                
                        }
                    }
                    
                    Button {
                        showDailyTask = true
                    } label: {
                        ZStack {
                            Image(.dailyTaskIconSR)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 180:100)
                            
                            
                                
                        }
                    }
                    
                    Button {
                        showAchievement = true
                    } label: {
                        ZStack {
                            Image(.achiIconSR)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 180:100)
                            
                        }
                    }
                }
                Spacer()
            }.padding(30)
            
            
        }
        .background(
            ZStack {
                Image(.appBgSR)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .fullScreenCover(isPresented: $showGame) {
            SRGameLevelsView()
        }
        .fullScreenCover(isPresented: $showAbility) {
            SRAbilitiesView(viewModel: shopVM)
        }
        .fullScreenCover(isPresented: $showAchievement) {
            SRAchivementsView(viewModel: achievementVM)
        }
        .fullScreenCover(isPresented: $showSettings) {
            SRSettingsView(settingsVM: settingsVM)
        }.fullScreenCover(isPresented: $showDailyTask) {
            SRDailyTaskView()
        }
        
        
        
        
    }
    
}

#Preview {
    SRMenuView()
}
