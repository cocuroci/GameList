import Foundation
import CoreData

extension CDGame {
    var idWrapped: UUID {
        id ?? UUID()
    }
    
    var nameWrapped: String {
        name ?? "Desconhecido"
    }
    
    var releaseDateWrapped: Date {
        releaseDate ?? Date()
    }
    
    var developersWrapped: String {
        developers ?? "Desconhecido"
    }
    
    var platformWrapped: Game.Platform {
        Game.Platform(rawValue: platform ?? "") ?? Game.Platform.switch
    }
}
