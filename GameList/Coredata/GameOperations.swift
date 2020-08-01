import Foundation
import CoreData
import Combine

final class GameOperations {
    private let context: NSManagedObjectContext
    private let gameListing: GameListRequest
    
    private(set) var fetchedGames: AnyPublisher<[Game], Never>
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        let request: NSFetchRequest = CDGame.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
        
        self.gameListing = GameListRequest(request: request, context: context)
        self.fetchedGames = gameListing.resultFetched.eraseToAnyPublisher()
    }
    
    func add(game: Game) {
        let newGame = CDGame(context: context)
        newGame.id = game.id
        newGame.name = game.name
        newGame.developers = game.developers
        newGame.releaseDate = game.releaseDate
        newGame.platform = game.platform.name
        saveContext()
    }
    
    func delete(game: Game) {
        let request: NSFetchRequest = CDGame.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", game.id.uuidString)
        
        do {
            let result = try context.fetch(request)
            guard let resultGame = result.first else { return }
            
            context.delete(resultGame)
            saveContext()
        } catch {
            debugPrint(self, error)
        }
    }
    
    private func saveContext() {
        try? context.save()
    }
}
