//
//  GamesTableViewCell.swift
//  Home
//
//  Created by Mochammad Arief Ridwan on 13/03/23.
//

import UIKit
import Cosmos
import Reusable

class GamesTableViewCell: UITableViewCell, NibReusable {
  
  @IBOutlet weak var listImage: UIImageView!
  @IBOutlet weak var cosmos: CosmosView!
  @IBOutlet weak var listTitle: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var platformView: UIView!
  @IBOutlet weak var releaseDateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.activityIndicator.startAnimating()
    self.cosmos.settings.fillMode = .precise
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
