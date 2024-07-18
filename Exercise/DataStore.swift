//
//  DataStore.swift
//  Exercise
//
//  Created by yoga arie on 18/07/24.
//
import CoreData
import Foundation
import UIKit




class DataStore {
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  static let shared = DataStore()
  var itemFood: [FoodItem] = []
  
  private init() {}
  
  func fetchFoodItems(completion: @escaping ([FoodItem]) -> Void) {
    let request: NSFetchRequest<FoodItem> = FoodItem.fetchRequest()
    do {
      let items = try context.fetch(request)
      DispatchQueue.main.async {
        self.itemFood = items
//        NotificationCenter.default.post(name: .itemFoodUpdated, object: nil)
        completion(items)
      }
    } catch {
      print("Error fetching Food Items: \(error)")
      DispatchQueue.main.async {
        completion([])
      }
    }
  }
  
  func deleteFoodItem(completion: @escaping (Bool) -> Void) {
    let request: NSFetchRequest<NSFetchRequestResult> = FoodItem.fetchRequest()
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
    
    do {
      try context.execute(deleteRequest)
      try context.save()
      DispatchQueue.main.async {
        self.itemFood = []
//        NotificationCenter.default.post(name: .itemFoodUpdated, object: nil)  
        completion(true)
      }
    } catch {
      DispatchQueue.main.async {
        completion(false)
      }
    }
  }
  
  
  
}
