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

public class HomePresenter {
 
  let homeUseCase: HomeUseCase
  let disposeBag = DisposeBag()
  
  var games: [Game] = []
  var errorMessage: String = ""
  var loadingState: Bool = false
  
  public init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }
  
  public func getGames(completion: @escaping () -> Void) {
    loadingState = true
    homeUseCase.getGames()
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
