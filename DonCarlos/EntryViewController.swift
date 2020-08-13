//
//  EntryViewController.swift
//  DonCarlos
//
//  Created by Juan Bulla on 25/06/2020.
//  Copyright © 2020 Pignusg. All rights reserved.
//

import RealmSwift
import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    @IBOutlet var bodyField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    
    
    private let realm = try! Realm()
    public var completionHandler: ((String, String, Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyField.delegate = self
        textField.delegate = self
        datePicker.setDate(Date(), animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Guardar", style: .done, target: self, action: #selector(didTapSaveButton))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func didTapSaveButton() {
        if let text = textField.text, !text.isEmpty,
            let farm = bodyField.text, !farm.isEmpty{
            let date = datePicker.date
            
            realm.beginWrite()
            
            let newItem = ToDoListItem()
            newItem.date = date
            newItem.item = text
            newItem.farm = farm
            realm.add(newItem)
            try! realm.commitWrite()
            
            completionHandler?(text, farm, date)
            navigationController?.popToRootViewController(animated: true)
        }
        else {
            print("Escribí alguna tarea")
        }
    }


    
}
