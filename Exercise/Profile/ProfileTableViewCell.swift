//
//  ProfileTableViewCell.swift
//  Exercise
//
//  Created by yoga arie on 17/07/24.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

  @IBOutlet weak var settingsButton: UIImageView!
  @IBOutlet weak var toggleButton: UISwitch!
  @IBOutlet weak var subtitleSetting: UILabel!
  @IBOutlet weak var titleSetting: UILabel!
  @IBOutlet weak var imageSetting: UIImageView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
