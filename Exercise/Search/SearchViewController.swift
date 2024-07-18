//
//  SearchViewController.swift
//  Exercise
//
//  Created by yoga arie on 17/07/24.
//

import UIKit

class SearchViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
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

  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Search"
    navigationController?.navigationBar.prefersLargeTitles = true
    collectionView.register(UINib(nibName: "SearchViewCell", bundle: nil), forCellWithReuseIdentifier: "searching_cell")
    collectionView.register(UINib(nibName: "SearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "search_cell")
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
 
  
}


extension SearchViewController: UICollectionViewDataSource {
  
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    case 1:
      return foodsData.count
    default:
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    switch indexPath.section {
    case 0:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searching_cell", for: indexPath) as! SearchViewCell
      
      return cell
      
    case 1:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "search_cell", for: indexPath) as! SearchCollectionViewCell
      let food = foodsData[indexPath.item]
      cell.foodImage.image = UIImage(named: food.image)
      cell.foodLabel.text = food.title
      cell.location.text = food.location
      return cell
      
    default:
      return UICollectionViewCell()
    }
    return UICollectionViewCell()
  }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch indexPath.section {
    case 0:
      return CGSize(width: 335, height: 48)
      
    case 1:
      return CGSize(width: 160, height: 198)
      
    default:
      return CGSize(width: 0, height: 0)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }
  
  
}
