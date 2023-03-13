//
//  AboutViewController.swift
//  About
//
//  Created by Mochammad Arief Ridwan on 13/03/23.
//

import UIKit

public class AboutViewController: UIViewController {
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    setNavigationItem()
  }
  
  private func setNavigationItem() {
    if #available(iOS 11.0, *) {
      self.navigationController?.navigationBar.prefersLargeTitles = true
      self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    self.title = "About"
    self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
  }
}
