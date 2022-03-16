//
//  NewEmojiTableViewController.swift
//  EmojiReader
//
//  Created by brubru on 16.03.2022.
//

import UIKit

class NewEmojiTableViewController: UITableViewController {
    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        
        for textField in [emojiTextField, nameTextField, descriptionTextField] {
            textField?.addTarget(
                self,
                action: #selector(descriptionTextFieldDidChanged),
                for: .editingChanged
            )
        }
    }
    
    @objc private func descriptionTextFieldDidChanged() {
        let emojiTF = emojiTextField.text ?? ""
        let nameTF = nameTextField.text ?? ""
        let descriptionTF = descriptionTextField.text ?? ""
        
        saveButton.isEnabled = !emojiTF.isEmpty && !nameTF.isEmpty && !descriptionTF.isEmpty
    }
    
}

extension NewEmojiTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emojiTextField {
            nameTextField.becomeFirstResponder()
        } else if textField == nameTextField {
            descriptionTextField.becomeFirstResponder()
        }
        return true
    }
    
    
}