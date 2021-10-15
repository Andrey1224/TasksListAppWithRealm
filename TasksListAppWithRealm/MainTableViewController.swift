//
//  MainTableViewController.swift
//  TasksListAppWithRealm
//
//  Created by Andrii Nepodymka on 10/11/21.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    
    var myImage = UIImage()
    var taskArray = TasksModel.getTasks()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return taskArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        
        let taskPath = taskArray[indexPath.row]
        
        cell.myLabel.text = taskPath.task
        if taskPath.image == nil {
            cell.myImage.image = UIImage(named: taskPath.taskImage!)
        } else {
            cell.myImage.image = taskPath.image
        }
        cell.myImage.layer.cornerRadius = 30
        cell.myImage.clipsToBounds = true
        
    
        return cell
    }
    

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newTaskVC = segue.source as? NewTaskViewController else { return }
        
        newTaskVC.saveNewTask()
        taskArray.append(newTaskVC.newTask!)
        tableView.reloadData()
        
    }
    
    
}
