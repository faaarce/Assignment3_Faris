//
//  OrderTableViewCell.swift
//  Exercise
//
//  Created by yoga arie on 17/07/24.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

  @IBOutlet weak var descLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var foodName: UILabel!
  @IBOutlet weak var orderImage: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
