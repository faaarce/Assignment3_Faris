//
//  OrderViewController.swift
//  Exercise
//
//  Created by yoga arie on 17/07/24.
//

import UIKit
import CoreData


protocol OrderBadgesUpdateDelegate {
  func updateBadge(badgeNumber: Int)
}

class OrderViewController: UIViewController {
  
  let service = DatabaseService.shared
  
  var delegate: OrderBadgesUpdateDelegate?
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  var foodsData: [Food] = [] {
    didSet {
      delegate?.updateBadge(badgeNumber: foodsData.count)
    }
  }
  
  var historyData: [History] = []
  
  
  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Your Orders"
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "order_cell")
    fetchData()
    fetchHistory()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchData()
    fetchHistory()
    self.tabBarController?.tabBar.isHidden = false
  }
  
  func fetchData() {
    foodsData.removeAll()
    service.fetchTask { data, error in
      if let error {
        print(error)
      }
      
      if let data {
        self.foodsData = data
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
    }
  }
  
  func fetchHistory() {
    historyData.removeAll()
    service.fetchHistory { data, error in
      if let error {
        print(error)
      }
      if let data {
        self.historyData = data
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
    }
  }
  
}

extension OrderViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return foodsData.count
      
    case 1:
      return historyData.count
      
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "order_cell", for: indexPath) as! OrderTableViewCell
    
    switch indexPath.section {
    case 0:
      let foods = foodsData[indexPath.item]
      cell.orderImage.image = UIImage(named: foods.image ?? "bg 1")
      cell.foodName.text = foods.title
      cell.descLabel.text = foods.price.formattedAsCurrency()
      cell.locationLabel.text = foods.location
      return cell
      
    case 1:
      let history = historyData[indexPath.item]
      cell.orderImage.image = UIImage(named: history.image ?? "bg 1")
      cell.foodName.text = history.title
      cell.descLabel.text = history.price.formattedAsCurrency()
      cell.locationLabel.text = history.location
      return cell
      
    default:
      return UITableViewCell()
    }
  }
  
  
}

extension OrderViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    switch section {
      
    case 0:
      let view = UIView(frame: .zero)
      view.backgroundColor = .clear
      let label = UILabel(frame: .zero)
      view.addSubview(label)
      label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
      label.text = "UPCOMING ORDERS"
      label.textColor = .gray
      
      label.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
      ])
      
      let button = UIButton(type: .system)
      view.addSubview(button)
      
      button.setTitle("CLEAR ALL", for: .normal)
      button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
      button.tintColor = .gray
      button.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18)
      ])
      
      button.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
      
      return view
      
    case 1:
      if !historyData.isEmpty {
        
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let label = UILabel(frame: .zero)
        view.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.text = "PAST HISTORY"
        label.textColor = .gray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
          label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let button = UIButton(type: .system)
        view.addSubview(button)
        
        button.setTitle("CLEAR ALL", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
          button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18)
        ])
        
        button.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
        
        return view
      }
      else {
        
        return UIView(frame: .zero)
      }
      
    default:
      return UIView(frame: .zero)
      
    }
    
    
  }
  
  @objc func deleteItem() {
    service.deleteAllData(completion: {isDeleted in
      if isDeleted {
        self.foodsData = []
        self.tableView.reloadData()
      }
    })
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    switch section {
      
    case 0:
      if !foodsData.isEmpty {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let proceedButton = UIButton(type: .system)
        view.addSubview(proceedButton)
        proceedButton.setTitle("Proceed Payment", for: .normal)
        proceedButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        proceedButton.tintColor = .orange
        proceedButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          proceedButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
          proceedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18)
        ])
        
        proceedButton.addTarget(self, action: #selector(moveToCheckout), for: .touchUpInside)
        return view
      }
      else {
        
        return UIView(frame: .zero)
      }
      
    default :
      return UIView(frame: .zero)
      
    }
  }
  
  @objc func moveToCheckout() {
    let viewController = CheckoutViewController(nibName: "CheckoutViewController", bundle: nil)
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return section == 0 ? 32 : 50
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    switch indexPath.section {
    case 0:
      
      let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
        self.service.deleteFood(food: self.foodsData[indexPath.item])
        self.fetchData()
        completion(true)
      }
      return UISwipeActionsConfiguration(actions: [deleteAction])
      
    case 1:
      
      return UISwipeActionsConfiguration(actions: [])
    default:
      return UISwipeActionsConfiguration(actions: [])
      
    }
  }
}
