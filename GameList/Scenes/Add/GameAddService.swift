import Foundation

protocol GameAddServicing {
    func add(game: Game)
}

final class GameAddService: GameAddServicing {
    private let operations: GameOperations
    
    init(operations: GameOperations) {
        self.operations = operations
    }
    
    func add(game: Game) {
        operations.add(game: game)
    }
    
    deinit {
        debugPrint(#function, self)
    }
}
