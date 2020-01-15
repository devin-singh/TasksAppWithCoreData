//
//  CoreDataStack.swift
//  Task
//
//  Created by Devin Singh on 1/15/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    static let container: NSPersistentContainer = {
            // Name same as project
            let container = NSPersistentContainer(name: "Task")
        /// notice we have a LOAD PERSISTENCE built into this container
            container.loadPersistentStores() { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
            return container
        }()
    static var context: NSManagedObjectContext { return container.viewContext }
}

