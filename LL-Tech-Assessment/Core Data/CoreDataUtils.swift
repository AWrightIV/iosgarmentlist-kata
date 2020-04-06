//
//  CoreDataUtils.swift
//  LL-Tech-Assessment
//
//  Created by Allan Wright on 4/3/20.
//  Copyright © 2020 Allan Wright. All rights reserved.
//

import UIKit
import CoreData

func managedContext() -> NSManagedObjectContext {
    guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
        fatalError("Unable to read managed object context.")
    }
    return context
}
