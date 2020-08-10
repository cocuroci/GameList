import Foundation
import CoreData
import Combine

final class GameOperations {
    private let context: NSManagedObjectContext
    private let gameListing: GameListRequest
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.gameListing = GameListRequest(request: GameOperations.defaultRequest(), context: context)
    }
    
    func add(game: Game) {
        let newGame = CDGame(context: context)
        newGame.id = game.id
        newGame.name = game.name
        newGame.developers = game.developers
        newGame.releaseDate = game.releaseDate
        newGame.platform = game.platform.name
        newGame.done = game.done
        saveContext()
    }
    
    func delete(game: Game) {
        let request: NSFetchRequest = CDGame.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", game.id.uuidString)
        
        do {
            let result = try context.fetch(request)
            guard let resultGame = result.first else { return }
            
            context.delete(resultGame)
            saveContext()
        } catch {
            debugPrint(self, error)
        }
    }
    
    func updateStatus(game: Game) {
        let request: NSFetchRequest = CDGame.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", game.id.uuidString)
        
        do {
            let result = try context.fetch(request)
            guard let resultGame = result.first else { return }
            
            resultGame.done = !game.done
            saveContext()
        } catch {
            debugPrint(self, error)
        }
    }
    
    func fetch() -> AnyPublisher<[Game], Never> {
        gameListing.resultFetched.eraseToAnyPublisher()
    }
    
    func filter(isDone: Bool) {
        let request = GameOperations.defaultRequest()
        if isDone {
            request.predicate = NSPredicate(format: "done == %@", NSNumber(booleanLiteral: isDone))
        }
        gameListing.request = request
    }
    
    private static func defaultRequest() -> NSFetchRequest<CDGame> {
        let request: NSFetchRequest = CDGame.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "done", ascending: true),
            NSSortDescriptor(key: "releaseDate", ascending: false),
        ]
        return request
    }
    
    private func saveContext() {
        try? context.save()
    }
}
