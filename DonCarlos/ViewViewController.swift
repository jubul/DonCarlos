//
//  ViewViewController.swift
//  DonCarlos
//
//  Created by Juan Bulla on 25/06/2020.
//  Copyright © 2020 Pignusg. All rights reserved.
//

import RealmSwift
import UIKit

class ViewViewController: UIViewController {

    public var item: ToDoListItem?
    public var deletionHandler: (() -> Void)?
    
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var farmLabel: UILabel!
    
    private let realm = try! Realm()
    
    static let dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemLabel.text = item?.item
        farmLabel.text = item?.farm
        dateLabel.text = Self.dateFormatter.string(from: item!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    
    @objc private func didTapDelete () {
        guard let myItem = self.item else {
            return
        }
        
        realm.beginWrite()
        realm.delete(myItem)
        try! realm.commitWrite()
        
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }


}
