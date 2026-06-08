//
//  PersistentContainer.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import Foundation
import CoreData

class PersistentContainer {
    static let shared = PersistentContainer()
    private init () {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "db")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError ("Unresolved error \(error), \(error.userInfo) ")
            }
        })
        return container
        
    }()
}
