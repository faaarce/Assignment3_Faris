//
//  TabViewController.swift
//  Exercise
//
//  Created by yoga arie on 15/07/24.
//


import UIKit

class TabViewController: UITabBarController {
  
  let service = DatabaseService.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    NotificationCenter.default.addObserver(self, selector: #selector(updateBadge), name: .itemFoodUpdated, object: nil)
    updateBadge()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateBadge()
  }
  
  
  
  
  func setup() {
    //    let apiManager = APIManager()
    //LoginViewController(apiManager: apiManager)
    let loginVC = UINavigationController(rootViewController: HomeViewController(nibName: "HomeViewController", bundle: nil))
    
    
    let searchVC = UINavigationController(rootViewController: SearchViewController(nibName: "SearchViewController", bundle: nil))
    
    let orderVC = UINavigationController(rootViewController: OrderViewController(nibName: "OrderViewController", bundle: nil))
    
    let profileVC = UINavigationController(rootViewController: ProfileViewController(nibName: "ProfileViewController", bundle: nil))
    
    
    loginVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
    
    searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass.fill"))
    
    orderVC.tabBarItem = UITabBarItem(title: "Order", image: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "magnifyingglass.fill"))
    
    
    
    profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
    
    
    tabBar.tintColor = UIColor(hex: "EEA734", alpha: 1.0)
    tabBar.unselectedItemTintColor = UIColor(hex: "868686", alpha: 1.0)
    
    viewControllers = [loginVC, searchVC,  orderVC, profileVC]
  }
  
  //  func updateBadge(badgeNumber: Int) {
  //    DispatchQueue.main.async {
  //      self.viewControllers?[2].tabBarItem.badgeValue = badgeNumber > 0 ? String(badgeNumber) : nil
  //    }
  //  }
  
  @objc func updateBadge() {
    // Retrieve the count from shared DataStore
    //   let count = DataStore.shared.itemFood.count
    let count = service.itemFood.count
    DispatchQueue.main.async {
      // Update badge value for the 'Order' tab
      if let orderTab = self.viewControllers?[2].tabBarItem {
        orderTab.badgeValue = count > 0 ? "\(count)" : nil
      }
    }
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  
}


extension UIViewController {
  func showTabbarViewController() {
    let viewController = TabViewController()
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      let window = windowScene.windows.first(where: { $0.isKeyWindow })
      window?.rootViewController = viewController
      window?.makeKeyAndVisible()
    }
  }
}
