import Foundation
import CoreData

extension CDGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGame> {
        return NSFetchRequest<CDGame>(entityName: "CDGame")
    }

    @NSManaged public var name: String?
    @NSManaged public var platform: String?
    @NSManaged public var id: UUID?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var developers: String?
}
