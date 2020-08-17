import Foundation
import CoreData
import Combine

protocol GameListServicing {
    func add(game: Game)
    func delete(game: Game)
    func fetch() -> AnyPublisher<[Game], Never>
    func showDone(_ isDone: Bool)
    func updateStatus(game: Game)
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
    
    func showDone(_ isDone: Bool) {
        operations.showDone(isDone)
    }
    
    func updateStatus(game: Game) {
        operations.updateStatus(game: game)
    }
}
