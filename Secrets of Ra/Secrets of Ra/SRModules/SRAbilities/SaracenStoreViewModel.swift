class SaracenStoreViewModel: ObservableObject {
    @Published var shopTeamItems: [ItemSaracen] = [
        
        ItemSaracen(name: "bg2", image: "gameBg2SG", icon: "bgItem2IconSaracen", section: .backgrounds, price: 100),
        ItemSaracen(name: "bg1", image: "gameBg1SG", icon: "bgItem1IconSaracen", section: .backgrounds, price: 100),
        ItemSaracen(name: "bg3", image: "gameBg3SG", icon: "bgItem3IconSaracen", section: .backgrounds, price: 100),
        ItemSaracen(name: "bg4", image: "gameBg4SG", icon: "bgItem4IconSaracen", section: .backgrounds, price: 100),
        
        
        ItemSaracen(name: "skin1", image: "imageSkin2Saracen", icon: "iconSkin1Saracen", section: .skin, price: 100),
        ItemSaracen(name: "skin2", image: "imageSkin1Saracen", icon: "iconSkin2Saracen", section: .skin, price: 100),
        ItemSaracen(name: "skin3", image: "imageSkin3Saracen", icon: "iconSkin3Saracen", section: .skin, price: 100),
        ItemSaracen(name: "skin4", image: "imageSkin4Saracen", icon: "iconSkin4Saracen", section: .skin, price: 100),
         
    ]
    
    @Published var boughtItems: [ItemSaracen] = [
        ItemSaracen(name: "bg2", image: "gameBg2SG", icon: "bgItem2IconSaracen", section: .backgrounds, price: 100),
        ItemSaracen(name: "skin1", image: "imageSkin1SG", icon: "iconSkin1SG", section: .skin, price: 100),
    ] {
        didSet {
            saveBoughtItem()
        }
    }
    
    @Published var currentBgItem: ItemSaracen? {
        didSet {
            saveCurrentBg()
        }
    }
    
    @Published var currentPersonItem: ItemSaracen? {
        didSet {
            saveCurrentPerson()
        }
    }
    
    init() {
        loadCurrentBg()
        loadCurrentPerson()
        loadBoughtItem()
    }
    
    private let userDefaultsBgKey = "BgKeySaracen"
    private let userDefaultsPersonKey = "SkinItemKeySaracen"
    private let userDefaultsBoughtKey = "boughtItemsSaracen"

    
    func saveCurrentBg() {
        if let currentItem = currentBgItem {
            if let encodedData = try? JSONEncoder().encode(currentItem) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsBgKey)
            }
        }
    }
    
    func loadCurrentBg() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsBgKey),
           let loadedItem = try? JSONDecoder().decode(ItemSaracen.self, from: savedData) {
            currentBgItem = loadedItem
        } else {
            currentBgItem = shopTeamItems[0]
            print("No saved data found")
        }
    }
    
    func saveCurrentPerson() {
        if let currentItem = currentPersonItem {
            if let encodedData = try? JSONEncoder().encode(currentItem) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsPersonKey)
            }
        }
    }
    
    func loadCurrentPerson() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsPersonKey),
           let loadedItem = try? JSONDecoder().decode(ItemSaracen.self, from: savedData) {
            currentPersonItem = loadedItem
        } else {
            currentPersonItem = shopTeamItems[4]
            print("No saved data found")
        }
    }
    
    func saveBoughtItem() {
        if let encodedData = try? JSONEncoder().encode(boughtItems) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsBoughtKey)
        }
        
    }
    
    func loadBoughtItem() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsBoughtKey),
           let loadedItem = try? JSONDecoder().decode([ItemSaracen].self, from: savedData) {
            boughtItems = loadedItem
        } else {
            print("No saved data found")
        }
    }
    
}

struct ItemSaracen: Codable, Hashable {
    var id = UUID()
    var name: String
    var image: String
    var icon: String
    var section: StoreSection
    var price: Int
}
