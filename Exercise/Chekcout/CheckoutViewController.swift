//
//  CheckoutViewController.swift
//  Exercise
//
//  Created by yoga arie on 17/07/24.
//

import UIKit

class CheckoutViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  let service = DatabaseService.shared
  var foodItem: [Food] = []
  var totalPrice: Double = 0.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib(nibName: "CheckoutItemViewCell", bundle: nil), forCellReuseIdentifier: "checkoutItemCell")
    tableView.register(UINib(nibName: "SubtotalViewCell", bundle: nil), forCellReuseIdentifier: "subtotalCell")
    tableView.register(UINib(nibName: "CheckoutFinaliseCell", bundle: nil), forCellReuseIdentifier: "checkoutFinalCell")
    tableView.dataSource = self
    tableView.delegate = self
    loadData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.tabBar.isHidden = true
  }
  
  func loadData() {
    foodItem.removeAll()
    service.fetchTask { data, error in
      if let error {
        print(error)
      }
      
      if let data {
        self.foodItem = data
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
    }
  }
  
}

extension CheckoutViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0 :
      return foodItem.count
      
    case 1:
      return 1
      
    case 2:
      return 2
      
    default:
      return 0
    }
  }
  
  func calculateFoodPrice() -> Double {
    let totalPrice = foodItem.reduce(0.0) { sum, item in
      return sum + item.price
    }
    return totalPrice
  }
  
  func calculateDelivery() -> Double {
    let totalPrice = foodItem.reduce(0.0) { sum, item in
      return sum + item.deliveryFee
    }
    return totalPrice
  }
  
  func totalPrice(price: Double, delivery: Double) -> Double {
    totalPrice = price + delivery
    return totalPrice
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
      
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: "checkoutItemCell", for: indexPath) as! CheckoutItemViewCell
      let foodData = foodItem[indexPath.item]
      cell.quantityView.layer.borderWidth = 0.8
      cell.quantityView.layer.borderColor = UIColor(hex: "868686", alpha: 0.2).cgColor
      cell.quantityView.layer.cornerRadius = 4
      cell.foodName.text = foodData.title
      cell.foodDetail.text = foodData.location
      cell.priceLabel.text = foodData.price.formattedAsCurrency()
      return cell
      
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: "subtotalCell", for: indexPath) as! SubtotalViewCell
      let price = calculateFoodPrice()
      let delivery = calculateDelivery()
      let total = totalPrice(price: price, delivery: delivery)
      cell.totalFee.text = String(price.formattedAsCurrency())
      cell.deliveryFee.text = String(delivery.formattedAsCurrency())
      cell.subtotalPrice.text = String(total.formattedAsCurrency())
      return cell
      
    case 2:
      let cell = tableView.dequeueReusableCell(withIdentifier: "checkoutFinalCell", for: indexPath) as! CheckoutFinaliseCell
      
      return cell
      
    default:
      return UITableViewCell()
    }
    
    return UITableViewCell()
  }
  
}

extension CheckoutViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    switch section {
      
    case 0:
      return UIView()
    case 1:
      return UIView()
    case 2:
      let view = UIView(frame: .zero)
      view.backgroundColor = .clear
      let checkoutButton = UIButton(type: .system)
      view.addSubview(checkoutButton)
      checkoutButton.setTitle("Checkout (\(totalPrice.formattedAsCurrency()))", for: .normal)
      checkoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
      checkoutButton.backgroundColor = UIColor(hex: "EEA734", alpha: 1.0)
      checkoutButton.tintColor = .white
      checkoutButton.layer.cornerRadius = 8
      checkoutButton.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        checkoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        checkoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        checkoutButton.widthAnchor.constraint(equalToConstant: 335),
        checkoutButton.heightAnchor.constraint(equalToConstant: 48)
      ])
      checkoutButton.addTarget(self, action: #selector(successButton), for: .touchUpInside)
      return view
      
    default:
      return UIView()
    }
    
  }
  
  @objc func successButton() {
    
    let historyItem = foodItem.map { food -> History in
      return History(title: food.title, duration: food.duration, rating: food.rating, location: food.location, image: food.image, deliveryFee: food.deliveryFee, price: food.price)
    }
    service.historyFood = historyItem
    service.saveHistory(history: historyItem)
    let vc = SuccessCardViewController()
    vc.modalPresentationStyle = .overCurrentContext
    self.present(vc, animated: false)
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    switch section {
    case 0:
      return 0
    case 1:
      return 0
    case 2:
      return 60
    default:
      return 0
    }
    
  }
}
