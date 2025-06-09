//
//  SRDailyTaskView.swift
//  Secrets of Ra
//
//  Created by Dias Atudinov on 09.06.2025.
//

import SwiftUI

struct SRDailyTaskView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            VStack {
                HStack {
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
                        
                        Image(.dailyTaskTextSR)
                            .resizable()
                            .scaledToFit()
                        
                        Spacer()
                        Image(.backIconSR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 100:50)
                            .opacity(0)
                    }.padding([.top, .horizontal])
                }
                
                VStack {
                    
                    ZStack {
                        Image(.task1TextSR)
                            .resizable()
                            .scaledToFit()
                        
                        VStack {
                            Spacer()
                            Image(.priceHundredSR)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 100:50)
                                .padding(.bottom, 30)
                        }
                        
                    }.frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 300:150)
                    
                    ZStack {
                        Image(.task2TextSR)
                            .resizable()
                            .scaledToFit()
                        
                        VStack {
                            Spacer()
                            Image(.priceHundredSR)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 100:50)
                                .padding(.bottom, 30)
                        }
                        
                    }.frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 300:150)
                    
                    ZStack {
                        Image(.task3TextSR)
                            .resizable()
                            .scaledToFit()
                        
                        VStack {
                            Spacer()
                            Image(.priceHundredSR)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 100:50)
                                .padding(.bottom, 30)
                        }
                        
                    }.frame(height: SaracenDeviceInfo.shared.deviceType == .pad ? 300:150)
                }
                
                Spacer()
            }
        }.background(
            Image(.appBgSR)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
        )
    }
}

#Preview {
    SRDailyTaskView()
}
