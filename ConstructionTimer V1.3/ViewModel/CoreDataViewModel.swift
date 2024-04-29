//
//  CoreDataViewModel.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataViewModel: ObservableObject {
    let persistentContainer: NSPersistentContainer
    let dateFormatter = DateFormatter()
    
    @Published var savedEntities = [JikanEntity]()
    
    @Published var category: String = "None"
    @Published var delayDescription: String = "1hr GC delay"
    @Published var categoryColor: String = "Yellow"
    @Published var endTime: String = ""
    @Published var totalTime: String = ""
    
    @Published var editTasks: JikanEntity?
    
    init() {
        persistentContainer = NSPersistentContainer(name: "CoreDataContainer")
        persistentContainer.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                fatalError("Core Data storage failed \(error.localizedDescription)")
            }
        })
        // MARK:  add fetchdelay time
     //   fetchprojectDelayTime()
    }
    
    // MARK: Save entity to CoreData
    func addendtimeEntity(context: NSManagedObjectContext) -> Bool {
          var tasks: JikanEntity!
          if let editTasks = editTasks {
              tasks = editTasks
          } else {
              if case tasks.category = category {
                  if case tasks.delayDescription = delayDescription {
                      if case tasks.categoryColor = categoryColor {
                          if case tasks.endTime = endTime {
                              if case tasks.totaltime = totalTime {
                                  
                              }
                          }
                      }
                  }
              }
          }
  
          if let _ = try? context.save() {
              return true
          } else {
              return false
          }
      }
    

    func addTestTime() {

    }
    
    
    func addEndTime(category: String, delayDescription: String, categoryColor: String, endTime: String, totalTime: String, startDate: String) {
        let newEntityDelay = JikanEntity(context: persistentContainer.viewContext)
        newEntityDelay.totaltime = totalTime
        newEntityDelay.endTime = endTime
        newEntityDelay.category = category
        newEntityDelay.delayDescription = delayDescription
        newEntityDelay.categoryColor = categoryColor
        newEntityDelay.startDate = startDate
        
        
        print(category)
        print(delayDescription)
        print(categoryColor)
        print(startDate)
        print(endTime)
        print(totalTime)
        
        
        // MARK: add save Time here
        saveConstructionTime()
    }
    
    func deleteDelayTime(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        persistentContainer.viewContext.delete(entity)
        
        saveConstructionTime()
        
    }
    
    func saveDelays() {
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print("Error found while saving data")
        }
        fetchDelays()
    }
    
    func fetchDelays() {
        let fetchRequest = NSFetchRequest<JikanEntity>(entityName: "JikanEntity")
        
        do {
            savedEntities = try persistentContainer.viewContext.fetch(fetchRequest)
        } catch let error {
            print("Error fetching information \(error)")
        }
    }
    
    

    func saveConstructionTime() {
        do {
            try persistentContainer.viewContext.save()
            
            // MARK: add delaytime
        } catch let error {
            print("Error found while saving data \(error.localizedDescription)")
        }
        
        fetchprojectDelayTime()
        // MARK: add fetch request after saving through persistentContainer, or the refreshable will not update
    }
    
    func fetchprojectDelayTime() {
        let fetchRequest = NSFetchRequest<JikanEntity>(entityName: "JikanEntity")
        
        do {
            savedEntities = try persistentContainer.viewContext.fetch(fetchRequest)
            
        } catch let error {
            print("Error fetching information \(error)")
        }
    }
}
