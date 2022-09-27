//
//  DataController.swift
//  Cards
//
//  Created by Armin on 9/27/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Cards")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
