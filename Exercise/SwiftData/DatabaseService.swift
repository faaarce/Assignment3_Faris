//
//  DatabaseService.swift
//  Exercise
//
//  Created by yoga arie on 20/07/24.
//

import Foundation
import SwiftData

extension Notification.Name {
  static let itemFoodUpdated = Notification.Name("itemFoodUpdated")
}

class DatabaseService {
  static var shared = DatabaseService()
  var container: ModelContainer?
  var context: ModelContext?
  
  var itemFood: [Food] = []
  var historyFood: [History] = []
  
  init() {
    do {
      let schema = Schema([
        Food.self,
        History.self,
      ])
      
      let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
      container = try ModelContainer(for: schema, configurations: [modelConfiguration])
      if let container {
        context = ModelContext(container)
      }
    }
    catch {
      print(error)
    }
  }
  
  func saveFood(food: Food) {
    context?.insert(food)
  }
  
  func saveHistory(history: [History]) {

      for i in history {
        context?.insert(i)
      }
      do {
        try context?.save()
      } catch {
     
      }
    
  }



func fetchTask(onCompletion: @escaping([Food]?, Error?) -> Void) {
  let descriptor = FetchDescriptor<Food>(sortBy: [SortDescriptor<Food>(\.time)])
  
  do {
    let data = try context?.fetch(descriptor)
    self.itemFood = data ?? []
    NotificationCenter.default.post(name: .itemFoodUpdated, object: nil)
    onCompletion(data, nil)
  } catch {
    onCompletion(nil, error)
  }
}

func fetchHistory(onCompletion: @escaping([History]?, Error?) -> Void) {
  let descriptor = FetchDescriptor<History>(sortBy: [SortDescriptor<History>(\.time)])
  
  do {
    let data = try context?.fetch(descriptor)
    self.historyFood = data ?? []
    
    onCompletion(data, nil)
  } catch {
    onCompletion(nil, error)
  }
}


func deleteAllData(completion: @escaping(Bool) -> Void) {
  try? context?.delete(model: Food.self)
  self.itemFood = []
  NotificationCenter.default.post(name: .itemFoodUpdated, object: nil)
  completion(true)
}
  func deleteFood(food: Food) {
    let foodDelete = food
    context?.delete(foodDelete)
    NotificationCenter.default.post(name: .itemFoodUpdated, object: nil)
  }

/*
 func deleteTask(task: TodoModel) {
 let taskToBeDeleted = task
 context?.delete(taskToBeDeleted)
 }
 */
}
