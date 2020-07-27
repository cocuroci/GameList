import Foundation

struct Game: Identifiable {
    let id = UUID()
    let name: String
    let platform: Platform
    let releaseDate: Date
    let developers: String
    
    var releaseDateFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "pt-BR")
        return dateFormatter.string(from: releaseDate)
    }
    
    enum Platform {
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
