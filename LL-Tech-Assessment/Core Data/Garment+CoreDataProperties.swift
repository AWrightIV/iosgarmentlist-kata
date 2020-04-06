//
//  Garment+CoreDataProperties.swift
//  LL-Tech-Assessment
//
//  Created by Allan Wright on 4/3/20.
//  Copyright © 2020 Allan Wright. All rights reserved.
//

import Foundation
import CoreData

extension Garment: Identifiable {
    // Properties
    @NSManaged public var name: String
    @NSManaged public var created: Date

    // Identifiable
    @NSManaged public var id: UUID?

    // Public Methods
    convenience init(name: String) {
        self.init(name: name, created: Date.init())
    }

    convenience init(name: String, created: Date) {
        self.init(name: name, created: created, context: managedContext())
    }

    convenience init(name: String, created: Date, context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "Garment", in: context)!
        self.init(entity: entity, insertInto: context)

        self.name = name
        self.created = created
        self.id = UUID()
    }

    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<Garment> {
        return NSFetchRequest<Garment>(entityName: "Garment")
    }
}
