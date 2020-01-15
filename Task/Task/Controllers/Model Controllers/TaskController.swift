//
//  TaskController.swift
//  Task
//
//  Created by Devin Singh on 1/15/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    //Singleton
    let shared = TaskController()
    
    // MARK: - Properties
    var tasks: [Task] = [Task(name: "Test1"), Task(name: "Test", notes: "Hello", due: Date())]
    
    func add(taskWithName name: String, notes: String?, due: Date?) {
        
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        
    }
    
    func remove(task: Task) {
        
    }
    
    func saveToPersistentStore() {
        
    }
    
    func fetchTasks() -> [Task] {
        return [Task()]
    }
}
