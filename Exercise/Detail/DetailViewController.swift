//
//  DetailViewController.swift
//  Exercise
//
//  Created by yoga arie on 18/07/24.
//

import UIKit

import SwiftData

class DetailViewController: UIViewController {
  
  //SwiftData
  let service = DatabaseService.shared
  
  
  @IBOutlet weak var foodPrice: UILabel!
  @IBOutlet weak var foodImage: UIImageView!
  
  @IBOutlet weak var foodTimes: UILabel!
  
  @IBOutlet weak var deliveryFee: UILabel!
  @IBOutlet weak var rating: UILabel!
  @IBOutlet weak var foodLocation: UILabel!
  @IBOutlet weak var foodTitle: UILabel!
  @IBOutlet weak var takeAwayButton: UIButton!
  //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var detailFood: Foods?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBarController?.tabBar.isHidden = true
    takeAwayButton.layer.borderWidth = 0.8
    takeAwayButton.layer.cornerRadius = 8
    takeAwayButton.contentEdgeInsets = UIEdgeInsets(top: 15, left: 17, bottom: 15, right: 17)
    takeAwayButton.layer.borderColor = UIColor(hex: "EEA734", alpha: 1.0).cgColor
    setup()
    title = detailFood?.title
  }
  
  func formatCurrency(_ value: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "Rp"
    formatter.currencyGroupingSeparator = "."
    formatter.maximumFractionDigits = 0
    return formatter.string(from: NSNumber(value: value)) ?? "Rp0"
  }
  
  func setup() {
    foodImage.image = UIImage(named: detailFood?.image ?? "bg 1")
    foodTitle.text = detailFood?.title
    foodLocation.text = detailFood?.location
    foodTimes.text = "\(detailFood?.time ?? 0) min"
    rating.text = "\(detailFood?.rating ?? 0.0)"
    deliveryFee.text = detailFood?.delivery
    foodPrice.text = detailFood?.price.formattedAsCurrency()
    
  }
  
  @IBAction func addButtonTapped(_ sender: UIButton) {
    
    let foodItem = Food(title: detailFood?.title ?? "", duration: detailFood?.time ?? 0, rating: 0, location: detailFood?.location ?? "", image: detailFood?.image ?? "", deliveryFee: Double(detailFood?.delivery ?? "") ?? 0.0, price: detailFood?.price ?? 0.0)
    service.itemFood.append(foodItem)
    service.saveFood(food: foodItem)
  }
  
  
}

extension UIViewController {
  func moveToDetailPage(_ food: Foods) {
    let viewController = DetailViewController(nibName: "DetailViewController", bundle: nil)
    viewController.detailFood = food
    navigationController?.pushViewController(viewController, animated: true)
  }
}
