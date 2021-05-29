//
//  CoreDataManager.swift
//  CoreData+UserDefaults
//
//  Created by Mirajkar on 29/05/21.
//  Copyright © 2021 Mirajkar. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class CoreDataManager {
    var persons : [NSManagedObject] = []

    static var shared = CoreDataManager()
    private init () {
        
    }
    
    
    func saveData(name : String)  {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let personEntity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
        let person = NSManagedObject(entity: personEntity!, insertInto: managedContext)
        person.setValue(name, forKeyPath: "name")
        
        do {
          try managedContext.save()
          persons.append(person)
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchPersonData() -> [NSManagedObject] {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
            do {
              persons = try managedContext.fetch(fetchRequest)
            } catch let error as NSError {
              print("Could not fetch. \(error), \(error.userInfo)")
            }
            return persons
        }
     return persons
    }

}

