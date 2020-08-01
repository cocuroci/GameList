import Foundation

struct Game: Identifiable {
    let id: UUID
    let name: String
    let platform: Platform
    let releaseDate: Date
    let developers: String
    let releaseDateFormatted: String?
    
    init(id: UUID, name: String, platform: Platform, releaseDate: Date, developers: String, releaseDateFormatted: String? = nil) {
        self.id = id
        self.name = name
        self.platform = platform
        self.releaseDate = releaseDate
        self.developers = developers
        self.releaseDateFormatted = releaseDateFormatted
    }
    
    enum Platform: String, CaseIterable  {
        case `switch`
        case ps4
        case pc
        
        var name: String {
            switch self {
            case .pc:
                return "PC"
            case .ps4:
                return "PS4"
            case .switch:
                return "Switch"
            }
        }
    }
}
