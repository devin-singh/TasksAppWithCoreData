//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Devin Singh on 1/15/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    var task: Task? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    var dueDate: Date?
    
    // MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    @IBOutlet var tapGestureRecog: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueDateTextField.inputView = dueDatePicker
        view.addGestureRecognizer(tapGestureRecog)
        updateViews()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let name = taskNameTextField.text, let notes = notesTextView.text, let due = dueDate, !name.isEmpty, !notes.isEmpty else {return}
        
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: notes, due: due)
        }else{
            TaskController.shared.add(taskWithName: name, notes: notes, due: due)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDateTextField.text = dueDatePicker.date.stringValue()
        self.dueDate = sender.date
    }
    
    @IBAction func userTappedView(_ sender: Any) {
        self.taskNameTextField.resignFirstResponder()
        self.dueDateTextField.resignFirstResponder()
        self.notesTextView.resignFirstResponder()
    }
    
    func updateViews() {
        guard let task = task else {return}
        taskNameTextField.text = task.name
        dueDateTextField.text = task.due?.stringValue()
        notesTextView.text = task.notes
        self.title = task.name
    }
}
