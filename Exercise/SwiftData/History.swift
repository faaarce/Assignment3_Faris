//
//  History.swift
//  Exercise
//
//  Created by yoga arie on 21/07/24.
//

import Foundation
import SwiftData

@Model
class History {
  @Attribute(.unique) var id: String
  var title: String
  var duration: Int
  var rating: Int
  var location: String
  var image: String
  var deliveryFee: Double
  var price: Double
  var time: Double
  
  init(title: String, duration: Int, rating: Int, location: String, image: String, deliveryFee: Double, price: Double) {
    self.id = UUID().uuidString
    self.title = title
    self.duration = duration
    self.rating = rating
    self.location = location
    self.image = image
    self.deliveryFee = deliveryFee
    self.price = price
    self.time = Date().timeIntervalSince1970
  }
}
