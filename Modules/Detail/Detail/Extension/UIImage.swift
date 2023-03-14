//
//  UIImage.swift
//  Detail
//
//  Created by Mochammad Arief Ridwan on 14/03/23.
//

import Foundation
import UIKit

extension UIImageView {
  func load(url: URL) {
      DispatchQueue.global().async {
          if let data = try? Data(contentsOf: url) {
              if let image = UIImage(data: data) {
                  DispatchQueue.main.async {
                      self.image = image
                  }
              }
          }
      }
  }
  
  func load(url: URL, activityIndicator: UIActivityIndicatorView) {
    activityIndicator.isHidden = false
    activityIndicator.startAnimating()
      DispatchQueue.global().async {
          if let data = try? Data(contentsOf: url) {
              if let image = UIImage(data: data) {
                  DispatchQueue.main.async {
                      self.image = image
                    activityIndicator.stopAnimating()
                    activityIndicator.isHidden = true
                  }
              }
          }
      }
  }
}

extension UIImage {
    convenience init?(url: URL) {
        do {
            let imageData = try Data(contentsOf: url)
            self.init(data: imageData)
        } catch {
            print("Error loading image from URL: \(error.localizedDescription)")
            return nil
        }
    }
}
