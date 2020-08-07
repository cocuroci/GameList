import CoreData
import Foundation
import Combine

final class GameListRequest: NSObject, NSFetchedResultsControllerDelegate {
    private let context: NSManagedObjectContext
    private var controller: NSFetchedResultsController<CDGame>
    private(set) var resultFetched = CurrentValueSubject<[Game], Never>([])
    
    var request: NSFetchRequest<CDGame> {
        didSet {
            updateController()
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()
    
    init(request: NSFetchRequest<CDGame>, context: NSManagedObjectContext) {
        self.context = context
        self.request = request
        self.controller = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        super.init()
        performFetch()
    }
    
    private func updateController() {
        controller = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        performFetch()
    }
    
    private func performFetch() {
        do {
            controller.delegate = self
            try controller.performFetch()
            updateResult()
        } catch {
            
        }
    }
    
    private func updateResult() {
        let result = controller.fetchedObjects?.compactMap { object in
            Game(
                id: object.idWrapped,
                name: object.nameWrapped,
                platform: object.platformWrapped,
                releaseDate: object.releaseDateWrapped,
                developers: object.developersWrapped,
                releaseDateFormatted: self.dateFormatter.string(from: object.releaseDateWrapped),
                done: object.done
            )
        } ?? []
        
        resultFetched.send(result)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateResult()
    }
}
