//
//  HomeViewController.swift
//  Home
//
//  Created by Mochammad Arief Ridwan on 13/03/23.
//

import UIKit
import Common

public class HomeViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  public var presenter: HomePresenter?
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    setNavigationItem()
    self.registerCell()
    self.presenter?.getGames {
      self.tableView.reloadData()
    }
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
  
  func startDownload(game: Game, indexPath: IndexPath) {
      let imageDownloader = ImageDownloader()
      if game.state == .new {
        Task {
          do {
            guard let url = URL(string: game.backgroundImage ?? "") else { return }
            let image = try await imageDownloader.downloadImage(url: url)
            game.state = .downloaded
            game.image = image
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
          } catch {
            game.state = .failed
            game.image = nil
          }
        }
      }
    }
  
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.presenter?.games.count ?? 0
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: GamesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    guard let game = self.presenter?.games[indexPath.row] else {return cell}
    cell.listImage.image = game.image
    cell.game = game
    if self.presenter?.games[indexPath.row].state == .new {
      
      startDownload(game: game, indexPath: indexPath)
      }
    return cell
  }
  
  
}
