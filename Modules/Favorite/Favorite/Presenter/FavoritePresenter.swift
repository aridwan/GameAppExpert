//
//  HomePresenter.swift
//  Home
//
//  Created by Mochammad Arief Ridwan on 14/03/23.
//

import Foundation
import RxSwift
import Detail
import Common
import Home

public class FavoritePresenter {
 
  let favoriteUseCase: FavoriteUseCase
  let disposeBag = DisposeBag()
  
  var games: [Game] = []
  var errorMessage: String = ""
  var loadingState: Bool = false
  
  public init(favoriteUseCase: FavoriteUseCase) {
    self.favoriteUseCase = favoriteUseCase
  }
  
  public func getFavorites(completion: @escaping () -> Void) {
    loadingState = true
    favoriteUseCase.getFavorites()
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.games = result
      } onError: { error in
        self.errorMessage = error.localizedDescription
      } onCompleted: {
        self.loadingState = false
        completion()
      }.disposed(by: disposeBag)
  }
  
  func goToDetail(with game: Game, navigationController: UINavigationController) {
    guard let bundle = Bundle(identifier: "com.dicoding.academy.Detail") else {return}
    let viewController = DetailViewController(nibName: "DetailViewController", bundle: bundle)
    let detailUseCase = HomeInjection.init().provideDetail(game: game)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    presenter.game = game
    viewController.presenter = presenter
    navigationController.pushViewController(viewController, animated: true)
  }
}
