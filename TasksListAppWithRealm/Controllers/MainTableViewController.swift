//
//  MainTableViewController.swift
//  TasksListAppWithRealm
//
//  Created by Andrii Nepodymka on 10/11/21.
//

import UIKit
import RealmSwift

class MainTableViewController: UITableViewController {
    
    var taskArray: Results<TasksModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        taskArray = realm.objects(TasksModel.self)
        
    }

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.isEmpty ? 0 : taskArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        let taskPath = taskArray[indexPath.row]
        cell.myLabel.text = taskPath.task
        cell.myImage.image = UIImage(data: taskPath.imageData!)
        cell.myImage.layer.cornerRadius = 30
        cell.myImage.clipsToBounds = true
        return cell
    }
    
    
    //MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = taskArray[indexPath.row]
            StorageManager.deleteTask(task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let task = taskArray[indexPath.row]
            let newTaskVC = segue.destination as! NewTaskViewController
            newTaskVC.currentTask = task
            
        }
    }
    
    
    // вызывает после нажатия Save  берет   с вью контроллера с которого переходили ранее с NewTaskViewController
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newTaskVC = segue.source as? NewTaskViewController else { return }
        newTaskVC.saveTask()
        tableView.reloadData()
        
    }
}
