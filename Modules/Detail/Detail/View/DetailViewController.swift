//
//  DetailViewController.swift
//  Detail
//
//  Created by Mochammad Arief Ridwan on 14/03/23.
//

import UIKit
import Cosmos
import RxSwift
import RxCocoa

public class DetailViewController: UIViewController {
  
  @IBOutlet weak var gameTitleLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var addedLabel: UILabel!
  @IBOutlet weak var cosmos: CosmosView!
  @IBOutlet weak var gameImageView: UIImageView!
  @IBOutlet weak var esrbLabel: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var isLiked: Bool = false 
  public var presenter: DetailPresenter?
  let disposeBag = DisposeBag()
  var isCollectionViewHidden = false
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    setNavigationItem()
    registerCell()
    guard let presenterGame = self.presenter?.game else {return}
    self.presenter?.getDetailGame(game: presenterGame, completion: {
      self.descriptionLabel.text = self.presenter?.detailGame?.descriptionRaw
      self.cosmos.rating = self.presenter?.detailGame?.rating ?? 0.0
      self.addedLabel.text = "\(presenterGame.added ?? 0)"
      self.esrbLabel.text = presenterGame.esrbRating?.name?.rawValue
      self.collectionView.isHidden = self.isCollectionViewHidden
      self.gameTitleLabel.text = presenterGame.name
      if let savedImageData = presenterGame.savedImage {
        self.gameImageView.image = UIImage(data: savedImageData)
        self.activityIndicator.stopAnimating()
      } else {
        self.loadBigImage(urlString: presenterGame.backgroundImage ?? "", imageView: self.gameImageView)
      }
//      self.presenter?.checkFavorites(id: presenterGame.id ?? 0, completion: { game in
//        DispatchQueue.main.async {
//          if game != nil {
//            self.fillHeart()
//          } else {
//            self.emptyHeart()
//          }
//          self.setNavigationItem()
//        }
//      })
      
    })
  }
  
  private func loadBigImage(urlString: String, imageView: UIImageView) {
    guard let url = URL(string: urlString) else { return }
    imageView.load(url: url, activityIndicator: self.activityIndicator)
  }
  
  private func setNavigationItem() {
    self.title = self.presenter?.game?.name ?? ""
    let barButton = UIBarButtonItem(image: nil, style: .plain, target: nil, action: nil)
    if self.isLiked == true {
      barButton.image = UIImage(systemName: "heart.fill")
    } else {
      barButton.image = UIImage(systemName: "heart")
    }
    navigationItem.rightBarButtonItem = barButton
    navigationItem.rightBarButtonItem?.tintColor = UIColor.white
//    guard let presenterGame = self.presenter?.game, let imageString = self.presenter?.game?.backgroundImage, let imageUrl = URL(string: imageString), let bigImage = UIImage(url: imageUrl), let data = bigImage.pngData() else {return}
//    barButton.rx.tap.subscribe(onNext: {
//      if self.isLiked == false {
//        self.presenter?.setFavorites(game: presenterGame, image: data, completion: { result in
//          if result == true {
//            self.fillHeart()
//          }
//        })
//      } else {
//        self.presenter?.removeFavorites(game: presenterGame, completion: {result in
//          if result == true {
//            self.emptyHeart()
//          }
//        })
//      }
//    }).disposed(by: disposeBag)
    
  }
  
  private func registerCell(){
    self.collectionView.register(cellType: GameCollectionViewCell.self)
  }
  
  fileprivate func fillHeart() {
    self.isLiked = true
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: nil)
    self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    self.setNavigationItem()
  }
  
  fileprivate func emptyHeart() {
    self.isLiked = false
    DispatchQueue.main.async {
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: nil)
      self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
      self.setNavigationItem()
    }
  }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.presenter?.game?.shortScreenshots?.count ?? 0
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: GameCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    guard let imageUrl = URL(string: self.presenter?.game?.shortScreenshots?[indexPath.row].image ?? "") else { return cell}
    cell.imageView.load(url: imageUrl)
    return cell
  }
  
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let imageUrl = URL(string: self.presenter?.game?.shortScreenshots?[indexPath.row].image ?? "") else {return}
    self.gameImageView.load(url: imageUrl, activityIndicator: self.activityIndicator)
  }
}
