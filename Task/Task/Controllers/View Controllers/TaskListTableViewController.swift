//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Devin Singh on 1/15/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.shared.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tasksCell", for: indexPath) as? ButtonTableViewCell else {return ButtonTableViewCell()}
        let task = TaskController.shared.tasks[indexPath.row]
        
        cell.delegate = self
        cell.update(withTask: task)
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToRemove = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.remove(task: taskToRemove)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? TaskDetailTableViewController else {return}
            let task = TaskController.shared.tasks[indexPath.row]
            destinationVC.task = task
            destinationVC.dueDate = task.due
        }
        
    }
}
extension TaskListTableViewController: ButtonTableViewCellDelegate {
    // MARK: - ButtonTableViewCellDelegate
      func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
          guard let indexPath = tableView.indexPath(for: sender) else {return}
          let task = TaskController.shared.tasks[indexPath.row]
          TaskController.shared.toggleIsCompleteFor(task: task)
          sender.update(withTask: task)
      }
}
