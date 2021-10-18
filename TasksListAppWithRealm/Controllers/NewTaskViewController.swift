//
//  NewTaskViewController.swift
//  TasksListAppWithRealm
//
//  Created by Andrii Nepodymka on 10/11/21.
//

import UIKit

class NewTaskViewController: UITableViewController, UINavigationControllerDelegate {
    
    var currentTask: TasksModel?
    
    var imageIsChanged = false

    @IBOutlet weak var newTaskImage: UIImageView!
    
    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTextField.delegate = self
        saveButton.isEnabled = false
        taskTextField.addTarget(self, action: #selector(NewTaskViewController.textFieldDidChange(_:)), for: .editingChanged)
        setupEditScreen()
    }
//MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let alertActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
                self.imageIsChanged = true
            }
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
                self.imageIsChanged = true
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in  self.imageIsChanged = false}
            
            alertActionSheet.addAction(camera)
            alertActionSheet.addAction(photo)
            alertActionSheet.addAction(cancel)
            
            present(alertActionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }
    
    func saveTask() {
        var image: UIImage?
        
        if imageIsChanged {
            image = newTaskImage.image
        } else {
            image = UIImage(named: "addImage")
        }

        let imageData = image?.pngData()
        let newTask = TasksModel(task: taskTextField.text!, imageData: imageData)
        
        
        if currentTask != nil {
            try! realm.write {
                currentTask?.task = newTask.task
                currentTask?.imageData = newTask.imageData
            }
        } else {
            StorageManager.saveObject(newTask)
        }
    }
    
    func setupEditScreen() {
        
        if currentTask != nil {
            setupNavigationBar()
            imageIsChanged = true
            guard let data = currentTask?.imageData, let image = UIImage(data: data) else {return}
            newTaskImage.image = image
            newTaskImage.contentMode = .scaleAspectFill
            taskTextField.text = currentTask?.task
        }
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = nil
        title = currentTask?.task
        saveButton.isEnabled = true
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
//MARK: - TextFieldDelegate

extension NewTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if taskTextField.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

//MARK: - Work with Image

extension NewTaskViewController: UIImagePickerControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
            
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        newTaskImage.image = info[.editedImage] as? UIImage
        newTaskImage.contentMode = .scaleAspectFill
        newTaskImage.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
    
}
