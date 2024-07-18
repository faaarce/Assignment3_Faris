//
//  HomeViewController.swift
//  Exercise
//
//  Created by yoga arie on 16/07/24.
//

import UIKit

class HomeViewController: UIViewController {
  
  let foodsData: [Foods] = [
    Foods(image: "bg 1", title: "Mario Italiani", location: "Hay Street, Perth City", rating: 4.2, time: 20, delivery: "3000", price: 89000),
    Foods(image: "bg 2", title: "Cookie Sandwich", location: "Chinese", rating: 4.0, time: 15, delivery: "3000", price: 55000),
    Foods(image: "bg 3", title: "Cookie Sandwich", location: "Chinese", rating: 4.0, time: 15, delivery: "3000", price: 55000),
    Foods(image: "bg 4", title: "Split Bread", location: "Russian", rating: 3.5, time: 30, delivery: "0", price: 42500),
    Foods(image: "bg 5", title: "Mixt", location: "Yerba Buena", rating: 4.3, time: 10, delivery: "20000", price: 74500),
    Foods(image: "bg 6", title: "Popeyes", location: "1426 Flmst", rating: 4.1, time: 12, delivery: "2500", price: 99500),
    Foods(image: "bg 7", title: "The Halal Guys", location: "Yemen", rating: 4.8, time: 18, delivery: "0", price: 109900),
    Foods(image: "bg 8", title: "The Halal Guys", location: "Yemen", rating: 4.8, time: 18, delivery: "0", price: 109900),
    Foods(image: "bg 9", title: "Mc'Donalds", location: "Burkino Faso", rating: 3.8, time: 15, delivery: "1990", price: 64900)
  ]
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateOrderBadge()
    self.tabBarController?.tabBar.isHidden = false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Home"
    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    collectionView.register(UINib(nibName: "HorizontalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "horizontalCell")
    collectionView.register(UINib(nibName: "HeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
    collectionView.register(UINib(nibName: "AllFoodViewCell", bundle: nil), forCellWithReuseIdentifier: "allFoodCell")
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  func updateOrderBadge() {
    if let tabBarController = self.tabBarController as? TabViewController {
      tabBarController.updateBadge()
    }
  }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0 :
      return 1
      
    case 1:
      return 1
      
    case 2:
      return 1
      
    case 3:
      return 1
      
    case 4:
      return foodsData.count
      
    default:
      return 0
      
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    switch indexPath.section {
    case 0:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontalCell", for: indexPath) as! HorizontalCollectionViewCell
      cell.cellType = .banner
      return cell
      
    case 1:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontalCell", for: indexPath) as! HorizontalCollectionViewCell
      
      cell.cellType = .foodCard
      cell.delegate = self
      return cell
      
      
    case 2:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontalCell", for: indexPath) as! HorizontalCollectionViewCell
      cell.cellType = .banner
      return cell
      
      
    case 3:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontalCell", for: indexPath) as! HorizontalCollectionViewCell
      cell.cellType = .foodCard
      return cell
      
    case 4:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allFoodCell", for: indexPath) as! AllFoodViewCell
      let foods = foodsData[indexPath.item]
      cell.foodImage.image = UIImage(named: foods.image)
      cell.foodTitle.text = foods.title
      return cell
      
      
    default:
      return UICollectionViewCell()
    }
  }
}

extension HomeViewController: HorizontalCellDelegate {
  func didTapCell(_ food: Foods) {
    moveToDetailPage(food)
  }
  
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch indexPath.section {
      
    case 0:
      return CGSize(width: self.view.frame.width, height: 220)
      
    case 1:
      return CGSize(width: self.view.frame.width, height: 260)
      
    case 2:
      return CGSize(width: self.view.frame.width, height: 220)
      
    case 3:
      return CGSize(width: self.view.frame.width, height: 260)
      
    case 4:
      return CGSize(width: 335, height: 282)
      
      
    default:
      return CGSize(width: 0, height: 0)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:
      if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? HeaderReusableView {
        switch indexPath.section {
        case 0:
          headerView.headerLabel.text = ""
          headerView.isHidden = true
          return headerView
        case 1:
          headerView.headerLabel.text = "Featured Partners"
          headerView.isHidden = false
          return headerView
        case 2, 3:
          headerView.headerLabel.text = "Best Picks Restaurants by team"
          headerView.isHidden = false
          return headerView
        case 4:
          headerView.headerLabel.text = "All Restaurants"
          headerView.isHidden = false
          return headerView
        default:
          return HeaderReusableView()
        }
        
        
      }
      
    default:
      return UICollectionReusableView()
    }
    return UICollectionReusableView()
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    if section == 0 {
      return CGSize(width: 0, height: 0)
    } else if section == 4{
      return CGSize(width: collectionView.frame.width, height: 70)
    } else {
      return CGSize(width: collectionView.frame.width, height: 100)
    }
  }
  
  
}
