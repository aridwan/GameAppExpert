//
//  HomePresenter.swift
//  Home
//
//  Created by Mochammad Arief Ridwan on 14/03/23.
//

import Foundation
import RxSwift

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
}
