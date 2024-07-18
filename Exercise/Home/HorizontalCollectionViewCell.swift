//
//  HorizontalCollectionViewCell.swift
//  Exercise
//
//  Created by yoga arie on 16/07/24.
//

import UIKit

protocol HorizontalCellDelegate: AnyObject {
  func didTapCell(_ food: Foods)
}

enum CellType {
  case banner
  case foodCard
}

class HorizontalCollectionViewCell: UICollectionViewCell {
  
  var cellType: CellType = .banner
  
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


  
  weak var delegate: HorizontalCellDelegate?
  
  @IBOutlet weak var horizontalCollectionView: UICollectionView!
  override func awakeFromNib() {
    super.awakeFromNib()
    self.horizontalCollectionView.dataSource = self
    self.horizontalCollectionView.delegate = self
    self.horizontalCollectionView.register(UINib(nibName: "FoodCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "foodCard")
    self.horizontalCollectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "bannerCell")
    
  }
  
  
}

extension HorizontalCollectionViewCell: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return foodsData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    switch cellType {
      
    case .foodCard:
      let cell = horizontalCollectionView.dequeueReusableCell(withReuseIdentifier: "foodCard", for: indexPath) as! FoodCardCollectionViewCell
      let food = foodsData[indexPath.item]
      let delivery = Double(food.delivery)?.formattedAsCurrency()
      cell.cardFoodImage.image = UIImage(named: food.image)
      cell.cardFoodTitle.text = food.title
      cell.ratingLabel.text = String(food.rating)
      cell.deliveryLabel.text = delivery
      cell.cardFoodLocation.text = food.location
      cell.timeLabel.text = "\(food.time) min"
      return cell
      
    case .banner:
      let cell = horizontalCollectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as!
      BannerCollectionViewCell
      cell.bannerImage.image = UIImage(named: "Header")
      return cell
    }
  }
}

extension HorizontalCollectionViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch cellType {
    case .banner:
      CGSize(width: 335, height: 220)
    case .foodCard:
      CGSize(width: 200, height: 260)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
  }
}

extension HorizontalCollectionViewCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let food = foodsData[indexPath.row]
    delegate?.didTapCell(food)
    
  }
}
