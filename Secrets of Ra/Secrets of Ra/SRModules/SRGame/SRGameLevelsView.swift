//
//  SRGameLevelsView.swift
//  Secrets of Ra
//
//

import SwiftUI

struct SRGameLevelsView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var user = UserSR.shared
    @State var currentIndex: Int?
    @State var showGame = false
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
                
                let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)
                
                ScrollView {
                    VStack {
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(Range(0...9)) { index in
                                ZStack {
                                    Image(.levelNumBgSR)
                                        .resizable()
                                        .scaledToFit()
                                    TextWithBorderSR(text: "\(index + 1)", font: .system(size: SRDeviceInfo.shared.deviceType == .pad ? 70:39), textColor: .white, borderColor: .red, borderWidth: 1)
                                }.frame(height: SRDeviceInfo.shared.deviceType == .pad ? 200:100)
                                    .onTapGesture {
                                        showGame = true
                                        DispatchQueue.main.async {
                                            currentIndex = index
                                        }
                                    }
                            }
                        }
                    }
                }
            }
        }.background(
            ZStack {
                Image(.appBgSR)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .fullScreenCover(isPresented: $showGame) {
            if let currentIndex = currentIndex {
                SRGameView(level: currentIndex) {
                    self.currentIndex = nil
                }
            }
        }
        
    }
}

#Preview {
    SRGameLevelsView()
}
