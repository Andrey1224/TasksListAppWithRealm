//
//  TasksModel.swift
//  TasksListAppWithRealm
//
//  Created by Andrii Nepodymka on 10/11/21.
//

import Foundation
import UIKit


struct TasksModel {
    
    var task: String
    var image : UIImage?
    var taskImage: String?
    
   static var tasksArray = ["Mama", "Papa", "Sestra", "Brat"]
    
   static func getTasks() -> [TasksModel] {
        var tasks = [TasksModel]()
       for task in tasksArray {
           tasks.append(TasksModel(task: task, image: nil, taskImage: "addImage"))
        }
        
        
        
        return tasks
    }
    
}
