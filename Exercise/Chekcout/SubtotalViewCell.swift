//
//  SubtotalViewCell.swift
//  Exercise
//
//  Created by yoga arie on 17/07/24.
//

import UIKit

class SubtotalViewCell: UITableViewCell {

  @IBOutlet weak var subtotalPrice: UILabel!
  @IBOutlet weak var totalFee: UILabel!
  @IBOutlet weak var deliveryFee: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
