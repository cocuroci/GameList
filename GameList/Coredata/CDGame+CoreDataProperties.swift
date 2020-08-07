//
//  CDGame+CoreDataProperties.swift
//  GameList
//
//  Created by André Martins on 07/08/20.
//  Copyright © 2020 André Cocuroci. All rights reserved.
//
//

import Foundation
import CoreData


extension CDGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGame> {
        return NSFetchRequest<CDGame>(entityName: "CDGame")
    }

    @NSManaged public var developers: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var platform: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var done: Bool

}
