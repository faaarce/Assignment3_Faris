//
//  FoodCardCollectionViewCell.swift
//  Exercise
//
//  Created by yoga arie on 16/07/24.
//

import UIKit

class FoodCardCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var deliveryLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var cardFoodLocation: UILabel!
  @IBOutlet weak var cardFoodImage: UIImageView!
  @IBOutlet weak var cardFoodTitle: UILabel!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
