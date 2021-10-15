//
//  NewTaskViewController.swift
//  TasksListAppWithRealm
//
//  Created by Andrii Nepodymka on 10/11/21.
//

import UIKit

class NewTaskViewController: UITableViewController, UINavigationControllerDelegate {
    
    var newTask: TasksModel?

    @IBOutlet weak var newTaskImage: UIImageView!
    
    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTextField.delegate = self
        saveButton.isEnabled = false
        
        taskTextField.addTarget(self, action: #selector(NewTaskViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
//MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            
            
            let alertActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            alertActionSheet.addAction(camera)
            alertActionSheet.addAction(photo)
            alertActionSheet.addAction(cancel)
            
            present(alertActionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }
    
    func saveNewTask() {
        
        newTask = TasksModel(task: taskTextField.text!, image: newTaskImage.image, taskImage: nil)
        
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
