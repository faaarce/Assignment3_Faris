//
//  CheckoutItemViewCell.swift
//  Exercise
//
//  Created by yoga arie on 17/07/24.
//

import UIKit

class CheckoutItemViewCell: UITableViewCell {
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var foodDetail: UILabel!
  @IBOutlet weak var foodName: UILabel!
  @IBOutlet weak var quantityLabel: UILabel!
  @IBOutlet weak var quantityView: UIView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
