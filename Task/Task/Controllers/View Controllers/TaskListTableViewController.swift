//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Devin Singh on 1/15/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        TaskController.shared.fetchedResultsController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int { // checks task controller for number of sections, else displays zero
        return TaskController.shared.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TaskController.shared.fetchedResultsController.sectionIndexTitles[section] == "1" ? "Complete" : "Incomplete"
    }
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { // sets height for header
//        return 30.0
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tasksCell", for: indexPath) as? ButtonTableViewCell else {return UITableViewCell()}
        
        let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
    
        cell.delegate = self
        cell.update(withTask: task)
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
            TaskController.shared.remove(task: task)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? TaskDetailTableViewController else { return }
            let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
            destinationVC.task = task
            destinationVC.dueDate = task.due
        }
        
    }
}

extension TaskListTableViewController: ButtonTableViewCellDelegate, NSFetchedResultsControllerDelegate {
    // MARK: - ButtonTableViewCellDelegate
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        
        let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
        
        TaskController.shared.toggleIsCompleteFor(task: task)
        sender.update(withTask: task)
    }
    
    // MARK: - NSFRCDelegate
    
        // Conform to the NSFetchedResultsControllerDelegate
        func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            tableView.beginUpdates()
        }
        
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            tableView.endUpdates()
        }
        
        //sets behavior for cells
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
            
            switch type{
            case .delete:
                guard let indexPath = indexPath else { break }
                tableView.deleteRows(at: [indexPath], with: .fade)
            case .insert:
                guard let newIndexPath = newIndexPath else { break }
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            case .move:
                guard let indexPath = indexPath, let newIndexPath = newIndexPath else { break }
                tableView.moveRow(at: indexPath, to: newIndexPath)
            case .update:
                guard let indexPath = indexPath else { break }
                tableView.reloadRows(at: [indexPath], with: .automatic)
            @unknown default:
                fatalError()
            }
        }
        
        //additional behavior for cells
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
            
            switch type {
            case .insert:
                tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
            case .delete:
                tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
            case .move:
                break
            case .update:
                break
            @unknown default:
                fatalError()
            }
        }
    
}
