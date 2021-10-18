//
//  TasksModel.swift
//  TasksListAppWithRealm
//
//  Created by Andrii Nepodymka on 10/11/21.
//

import Foundation
import UIKit
import RealmSwift

class TasksModel: Object {
    @objc dynamic var task: String = ""
    @objc dynamic var imageData : Data?
    
    convenience init(task: String, imageData: Data?) {
        self.init()
        self.task = task
        self.imageData = imageData
    }
}
