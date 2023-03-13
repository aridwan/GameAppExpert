//
//  HomeViewController.swift
//  Home
//
//  Created by Mochammad Arief Ridwan on 13/03/23.
//

import UIKit

public class HomeViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    setNavigationItem()
    self.registerCell()
    tableView.reloadData()
  }
  
  private func registerCell() {
    self.tableView.register(cellType: GamesTableViewCell.self)
  }
  
  private func setNavigationItem() {
    if #available(iOS 11.0, *) {
      self.navigationController?.navigationBar.prefersLargeTitles = true
      self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    self.title = "Games"
    self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
  }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: GamesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    return cell
  }
  
  
}
