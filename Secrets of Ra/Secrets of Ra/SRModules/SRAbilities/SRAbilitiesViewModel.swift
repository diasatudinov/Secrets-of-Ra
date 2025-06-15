//
//  Secrets of Ra
//
//

import SwiftUI

class SRAbilitiesViewModel: ObservableObject {
    @Published var shopTeamItems: [ItemSR] = [
        
        ItemSR(name: "bgItem1IconSR", level: 0, price: 1000),
        ItemSR(name: "bgItem2IconSR", level: 0, price: 1000),
        ItemSR(name: "bgItem3IconSR", level: 0, price: 1000),
        ItemSR(name: "bgItem4IconSR", level: 0, price: 1000),
         
    ] {
        didSet {
            saveBoughtItem()
        }
    }
    
    init() {
        loadBoughtItem()
    }
    
    private let userDefaultsBoughtKey = "boughtItemsSR"

    func levelIncrease(item: ItemSR) {
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
           let loadedItem = try? JSONDecoder().decode([ItemSR].self, from: savedData) {
            shopTeamItems = loadedItem
        } else {
            print("No saved data found")
        }
    }
    
}

struct ItemSR: Codable, Hashable {
    var id = UUID()
    var name: String
    var level: Int
    var price: Int
}
