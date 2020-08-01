import Foundation
import CoreData
import Combine

final class CoreDataContainer {
    
    static let shared = CoreDataContainer()
    
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Games")
        container.loadPersistentStores { description, error in
            if let currentError = error {
                fatalError("Unable to load persistent stores: \(currentError)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
