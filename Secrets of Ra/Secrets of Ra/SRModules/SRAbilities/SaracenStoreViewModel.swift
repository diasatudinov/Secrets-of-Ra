//
//  SaracenStoreViewModel.swift
//  Secrets of Ra
//
//

import SwiftUI

class SaracenStoreViewModel: ObservableObject {
    @Published var shopTeamItems: [ItemSaracen] = [
        
        ItemSaracen(name: "bgItem1IconSR", level: 0, price: 1000),
        ItemSaracen(name: "bgItem2IconSR", level: 0, price: 1000),
        ItemSaracen(name: "bgItem3IconSR", level: 0, price: 1000),
        ItemSaracen(name: "bgItem4IconSR", level: 0, price: 1000),
         
    ] {
        didSet {
            saveBoughtItem()
        }
    }
    
    init() {
        loadBoughtItem()
    }
    
    private let userDefaultsBoughtKey = "boughtItemsSaracen"

    func levelIncrease(item: ItemSaracen) {
        if let index = shopTeamItems.firstIndex(where: { $0.name == item.name }) {
            shopTeamItems[index].level += 1
        }
    }
    
    func saveBoughtItem() {
        if let encodedData = try? JSONEncoder().encode(shopTeamItems) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsBoughtKey)
        }
        
    }
    
    func loadBoughtItem() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsBoughtKey),
           let loadedItem = try? JSONDecoder().decode([ItemSaracen].self, from: savedData) {
            shopTeamItems = loadedItem
        } else {
            print("No saved data found")
        }
    }
    
}

struct ItemSaracen: Codable, Hashable {
    var id = UUID()
    var name: String
    var level: Int
    var price: Int
}
