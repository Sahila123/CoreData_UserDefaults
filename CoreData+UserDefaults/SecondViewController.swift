//
//  SecondViewController.swift
//  CoreData+UserDefaults
//
//  Created by Mirajkar on 29/05/21.
//  Copyright © 2021 Mirajkar. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var doNotOpenButton: UIButton!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func doNotOpenVCBtnPressed(_ sender: Any) {
        defaults.set(false, forKey: "openVCDirectly")
        //self.navigationController?.popViewController(animated: true)
    }
    
    
}
