import Foundation
import CoreData
import Combine

protocol GameListServicing {
    func add(game: Game)
    func delete(game: Game)
    func fetch() -> AnyPublisher<[Game], Never>
    func filter(isDone: Bool)
}

final class GameListService: GameListServicing {
    private let operations: GameOperations

    init(operations: GameOperations) {
        self.operations = operations
    }
    
    func add(game: Game) {
        operations.add(game: game)
    }
    
    func delete(game: Game) {
        operations.delete(game: game)
    }
    
    func fetch() -> AnyPublisher<[Game], Never> {
        operations.fetch()
    }
    
    func filter(isDone: Bool) {
        operations.filter(isDone: isDone)
    }
}
