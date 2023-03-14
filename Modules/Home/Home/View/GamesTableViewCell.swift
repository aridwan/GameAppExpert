//
//  GamesTableViewCell.swift
//  Home
//
//  Created by Mochammad Arief Ridwan on 13/03/23.
//

import UIKit
import Cosmos
import Reusable
import Common

class GamesTableViewCell: UITableViewCell, NibReusable {
  
  @IBOutlet weak var listImage: UIImageView!
  @IBOutlet weak var cosmos: CosmosView!
  @IBOutlet weak var listTitle: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var platformView: UIView!
  @IBOutlet weak var releaseDateLabel: UILabel!
  
  var game: Game? {
    didSet {
      self.removeAllSubviews(view: platformView)
      self.listTitle.text = self.game?.name
      self.activityIndicator.stopAnimating()
      self.cosmos.rating = self.game?.rating ?? 0.0
      self.releaseDateLabel.text = "Release date \(self.game?.released ?? "")"
      self.setPlatformIcon(platforms: game?.parentPlatforms ?? [ParentPlatform](), view: self.platformView)
      if let imageData = game?.savedImage {
        self.listImage.image = UIImage(data: imageData)
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.activityIndicator.startAnimating()
    self.cosmos.settings.fillMode = .precise
  }
  
  private func removeAllSubviews(view: UIView) {
    for item in view.subviews {
      item.removeFromSuperview()
    }
  }
    
  private func setPlatformIcon(platforms: [ParentPlatform], view: UIView) {
    var count = 0
    for item in platforms {
      
      guard let bundle = Bundle(identifier: "com.dicoding.academy.Home") else {return}
      
      let image = UIImage(named: item.platform?.slug?.rawValue ?? "", in: bundle, with: nil)
      let imageView = UIImageView(frame: CGRect(x: (25 * count), y: 0, width: 17, height: 17))
      imageView.image = image
      view.addSubview(imageView)
      count += 1
    }
  }
  
}
