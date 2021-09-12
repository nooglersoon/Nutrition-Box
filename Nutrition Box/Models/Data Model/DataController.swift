//
//  DataController.swift
//  Nutrition Box
//
//  Created by Fauzi Achmad B D on 11/09/21.
//

import Foundation
import CoreData

class DataController {
    
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        
        persistentContainer = NSPersistentContainer(name: modelName)
        
    }
    
    // MARK: Load The Store
    
    func load(completion: (()->Void)? = nil) {
        
        persistentContainer.loadPersistentStores { storeDescription, error in
        
            guard error == nil else {
                
                fatalError(error!.localizedDescription)
                
            }
            
            self.autoSaving()
            completion?()
            
        
        }

    }
    
    // MARK: Autosaving
    
    func autoSaving(interval:TimeInterval = 30) {
        print("autosaving")
        
        guard interval > 0 else {
            debugPrint("cannot set negative autosave interval")
            return
        }
        
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaving(interval: interval)
        }
    }
    
    
    
    
}
