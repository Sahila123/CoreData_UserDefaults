//
//  ViewController.swift
//  CoreData+UserDefaults
//
//  Created by Mirajkar on 29/05/21.
//  Copyright © 2021 Mirajkar. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var openVCDirectly: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnPressed))
        self.navigationItem.rightBarButtonItem = leftBtn
        
        if defaults.bool(forKey: "openVCDirectly") {
            self.openVCDirectly.isUserInteractionEnabled = true
        } else {
            self.openVCDirectly.isUserInteractionEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let _ = CoreDataManager.shared.fetchPersonData()
        self.tableView.reloadData()
    }
    
    
    @IBAction func addBtnPressed(_ sender: Any) {
        
        let alert = UIAlertController.init(title: "New Name", message: "Add New Name", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Save", style: .default) { [unowned self] (action) in
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            print("\(nameToSave)")
            CoreDataManager.shared.saveData(name: nameToSave)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        alert.addAction(alertAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func openVCBtnPressed(_ sender: Any) {
        
        defaults.set(true, forKey: "openVCDirectly")
        guard let sVC = storyboard?.instantiateViewController(identifier: "SecondViewControllerID") as? SecondViewController else {
            return
        }
        
        self.navigationController?.pushViewController(sVC, animated: true)
    }
    
    
}


extension ViewController : UITableViewDataSource {
    // MARK: UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CoreDataManager.shared.persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let personObj = CoreDataManager.shared.persons[indexPath.row]
        cell?.textLabel?.text = personObj.value(forKey: "name") as? String
        return cell!
    }
    
}

