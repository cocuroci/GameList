import Foundation

protocol GameEditServicing {
    func update(game: Game)
}

final class GameEditService: GameEditServicing {
    private let operations: GameOperations
    
    init(operations: GameOperations) {
        self.operations = operations
    }
    
    func update(game: Game) {
        operations.update(game: game)
    }
}
