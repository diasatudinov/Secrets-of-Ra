//
//  SRAbilitiesView.swift
//  Secrets of Ra
//
//

import SwiftUI

struct SRAbilitiesView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var user = UserSR.shared
    @ObservedObject var viewModel: SRAbilitiesViewModel
    
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
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 100:50)
                        }
                        
                        
                        
                        Spacer()
                        
                        CoinBgSR()
                        
                        Spacer()
                        Image(.backIconSR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 100:50)
                            .opacity(0)
                    }.padding([.top, .horizontal])
                }
                
                VStack {
                    ForEach(viewModel.shopTeamItems, id: \.self) { item in
                        
                        ZStack {
                            Image(item.name)
                                .resizable()
                                .scaledToFit()
                            
                            VStack {
                                Spacer()
                                HStack {
                                    ZStack {
                                        Image(.levelBgSR)
                                            .resizable()
                                            .scaledToFit()
                                        
                                        TextWithBorderSR(text: "lvl \(item.level)", font: .system(size: SRDeviceInfo.shared.deviceType == .pad ? 20:10), textColor: .white, borderColor: .cyan, borderWidth: 1)
                                    }.frame(height: SRDeviceInfo.shared.deviceType == .pad ? 100: 50)
                                    
                                    Button {
                                        if user.money >= item.price {
                                            viewModel.levelIncrease(item: item)
                                            user.minusUserMoney(for: item.price)
                                        }
                                    } label: {
                                        Image(.priceThousandSR)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 90: 45)
                                    }
                                    
                                    ZStack {
                                        Image(.levelBgSR)
                                            .resizable()
                                            .scaledToFit()
                                        
                                        TextWithBorderSR(text: "lvl \(item.level)", font: .system(size: SRDeviceInfo.shared.deviceType == .pad ? 20:10), textColor: .white, borderColor: .cyan, borderWidth: 1)
                                    }.frame(height: SRDeviceInfo.shared.deviceType == .pad ? 100: 50)
                                        .opacity(0)
                                }.padding(.bottom, 25)
                            }
                        }.frame(height: SRDeviceInfo.shared.deviceType == .pad ? 250: 150)
                        
                    }
                }
                
                Spacer()
            }
        }.background(
            ZStack {
                Image(.appBgSR)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
    }
}

#Preview {
    SRAbilitiesView(viewModel: SRAbilitiesViewModel())
}
