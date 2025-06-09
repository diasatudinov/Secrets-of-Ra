import SwiftUI

class MGAchievementsViewModel: ObservableObject {
    
    @Published var achievements: [MGAchievement] = [
        MGAchievement(image: "achieve1ImageMG", isAchieved: false),
        MGAchievement(image: "achieve2ImageMG", isAchieved: false),
        MGAchievement(image: "achieve3ImageMG", isAchieved: false),
        MGAchievement(image: "achieve4ImageMG", isAchieved: false),
        MGAchievement(image: "achieve5ImageMG", isAchieved: false)

    ] {
        didSet {
            saveAchievementsItem()
        }
    }
    
    init() {
        loadAchievementsItem()
        
    }
    
    private let userDefaultsAchievementsKey = "achievementsKeyMG"
    
    func achieveToggle(_ achive: MGAchievement) {
        guard let index = achievements.firstIndex(where: { $0.id == achive.id })
        else {
            return
        }
        achievements[index].isAchieved.toggle()
        
    }
    
    
    func saveAchievementsItem() {
        if let encodedData = try? JSONEncoder().encode(achievements) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsAchievementsKey)
        }
        
    }
    
    func loadAchievementsItem() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsAchievementsKey),
           let loadedItem = try? JSONDecoder().decode([MGAchievement].self, from: savedData) {
            achievements = loadedItem
        } else {
            print("No saved data found")
        }
    }
}

struct MGAchievement: Codable, Hashable, Identifiable {
    var id = UUID()
    var image: String
    var isAchieved: Bool
}
