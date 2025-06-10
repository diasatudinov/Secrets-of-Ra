//
//  UserSaracen.swift
//  Secrets of Ra
//
//


import SwiftUI

class UserSaracen: ObservableObject {
    
    static let shared = UserSaracen()
    
    @AppStorage("money") var storedMoney: Int = 100
    @Published var money: Int = 100
    @Published var oldMoney = 0
    
    private init() {
        money = storedMoney
    }
    
    func updateUserMoney(for money: Int) {
        oldMoney = self.money
        self.money += money
        storedMoney = self.money
    }
    
    func minusUserMoney(for money: Int) {
        oldMoney = self.money
        self.money -= money
        if self.money < 0 {
            self.money = 0
        }
        storedMoney = self.money
        
    }
    
}
