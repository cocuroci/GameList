import SwiftUI
import Combine

protocol GameAddViewModelInput: ObservableObject {
    func addGame(with withName: String, plataform: String?, releaseDate: Date, developers: String, done: Bool)
}

final class GameAddViewModel: GameAddViewModelInput {
    private let service: GameAddServicing
    
    init(service: GameAddServicing) {
        self.service = service
    }
    
    func addGame(with withName: String, plataform: String?, releaseDate: Date, developers: String, done: Bool) {
        guard
            !withName.isEmpty,
            !developers.isEmpty,
            let plataform = plataform,
            let trasformedPlaftorm = Game.Platform(rawValue: plataform.lowercased())
            else {
                return
        }
        
        service.add(
            game: Game(
                id: UUID(),
                name: withName,
                platform: trasformedPlaftorm,
                releaseDate: releaseDate,
                developers: developers,
                done: done
            )
        )
    }
}
