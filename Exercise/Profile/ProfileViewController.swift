//
//  ProfileViewController.swift
//  Exercise
//
//  Created by yoga arie on 17/07/24.
//

import UIKit

class ProfileViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  let settings: [Setting] = [
    Setting(title: "Profile Information", subtitle: "Change your account information", image: "person.fill"),
    Setting(title: "Change Password", subtitle: "Change your password", image: "lock.fill"),
    Setting(title: "Payment Methods", subtitle: "Add your credit & debit cards", image: "creditcard.fill"),
    Setting(title: "Locations", subtitle: "Add or remove your delivery locations", image: "mappin.circle.fill"),
    Setting(title: "Add Social Account", subtitle: "Add Facebook, Twitter etc", image: "apple.logo"),
    Setting(title: "Refer to Friends", subtitle: "Get $10 for referring friends", image: "square.and.arrow.up.fill"),
  ]
  
  let notification: [Setting] = [
    Setting(title: "Push Notifications", subtitle: "For daily update you will get it", image: "bell.fill"),
    Setting(title: "SMS Notifications", subtitle: "For daily update you will get it", image: "bell.fill"),
    Setting(title: "Promotional Notifications", subtitle: "For daily update you will get it", image: "bell.fill"),
    
  ]
  
  let more: [Setting] = [
    Setting(title: "Rate Us", subtitle: "Rate us playstore, appstore", image: "star.fill"),
    Setting(title: "FAQ", subtitle: "Frequently asked questions", image: "book.closed.fill")
  ]
  
  let logout: [Setting] = [
    Setting(title: "Logout", subtitle: "", image: "rectangle.portrait.and.arrow.forward")
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Account Settings"
    navigationController?.navigationBar.prefersLargeTitles = true
    tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "profile_cell")
    tableView.dataSource = self
    tableView.delegate = self
  }
  
}


extension ProfileViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return settings.count
      
    case 1:
      return notification.count
      
    case 2:
      return more.count
    
    case 3:
      return logout.count
      
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "profile_cell", for: indexPath) as! ProfileTableViewCell
    
    switch indexPath.section {
    case 0:
      let settingItem = settings[indexPath.item]
      cell.imageSetting.image = UIImage(systemName: settingItem.image)
      cell.subtitleSetting.text = settingItem.subtitle
      cell.titleSetting.text = settingItem.title
      cell.toggleButton.isHidden = true
      return cell
      
    case 1:
      let settingItem = notification[indexPath.item]
      cell.imageSetting.image = UIImage(systemName: settingItem.image)
      cell.subtitleSetting.text = settingItem.subtitle
      cell.titleSetting.text = settingItem.title
      cell.settingsButton.isHidden = true
      return cell
      
      
    case 2:
      let settingItem = more[indexPath.item]
      cell.imageSetting.image = UIImage(systemName: settingItem.image)
      cell.subtitleSetting.text = settingItem.subtitle
      cell.titleSetting.text = settingItem.title
      cell.toggleButton.isHidden = true
      return cell
      
    case 3:
      let settingItem = logout[indexPath.item]
      cell.imageSetting.image = UIImage(systemName: settingItem.image)
      cell.subtitleSetting.text = settingItem.subtitle
      cell.titleSetting.text = settingItem.title
      cell.toggleButton.isHidden = true
      return cell
      
    default:
      return UITableViewCell()
    }
  }
}


extension ProfileViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return "Update your settings."
      
    case 1:
      return "NOTIFICATIONS"
      
    case 2:
      return "MORE"
    default:
      return ""
    }
    
  }
  
  
 
  
  
}

/*
 {
 func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
 
 return view
 }
 
 func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
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
 
 return view
 }
 
 func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
 return 32
 }
 }
 */
