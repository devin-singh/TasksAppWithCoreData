//
//  Task+Convenience.swift
//  Task
//
//  Created by Devin Singh on 1/15/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
    convenience init(name: String, notes: String? = nil, due: Date? = nil, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.due = due
    }
}
