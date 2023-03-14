//
//  FavoriteViewController.swift
//  Favorite
//
//  Created by Mochammad Arief Ridwan on 13/03/23.
//

import UIKit
import Home

public class FavoriteViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  public var presenter: FavoritePresenter?
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    setNavigationItem()
    registerCell()
  }
  
  public override func viewDidAppear(_ animated: Bool) {
    self.presenter?.getFavorites(completion: {
      if self.presenter?.games.count == 0 {
        self.tableView.isHidden = true
      } else {
        self.tableView.isHidden = false
      }
      self.tableView.reloadData()
    })
  }
  
  private func setNavigationItem() {
    if #available(iOS 11.0, *) {
      self.navigationController?.navigationBar.prefersLargeTitles = true
      self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    self.title = "Favorites"
    self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
  }
  
  func registerCell() {
    self.tableView.register(cellType: GamesTableViewCell.self)
  }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.presenter?.games.count ?? 0
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: GamesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    cell.game = self.presenter?.games[indexPath.row]
    return cell
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let game = self.presenter?.games[indexPath.row] else { return }
    self.presenter?.goToDetail(with: game, navigationController: self.navigationController ?? UINavigationController())
  }
}
