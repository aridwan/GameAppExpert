//
//  DetailPresenter.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 20/02/23.
//

import Foundation
import UIKit
import RxSwift
import Common

public class DetailPresenter: ObservableObject {
  public let detailUseCase: DetailUseCase
  public let disposeBag = DisposeBag()
 
  public var detailGame: DetailGame?
  public var game: Game?
  public var errorMessage: String = ""
  public var loadingState: Bool = false
  
  public init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
  }
  
  public func getDetailGame(game: Game, completion: @escaping () -> Void) {
    loadingState = true
    detailUseCase.getDetailGame(game: game)
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.detailGame = result
      } onError: { error in
        self.errorMessage = error.localizedDescription
      } onCompleted: {
        self.loadingState = false
        completion()
      }.disposed(by: disposeBag)
  }
  
//  func removeFavorites(game: Game, completion: @escaping (Bool) -> Void) {
//    detailUseCase.removeFavorites(game: game)
//      .observe(on: MainScheduler.instance)
//      .subscribe { _ in
//        completion(true)
//      } onError: { error in
//        self.errorMessage = error.localizedDescription
//      } onCompleted: {
//        self.loadingState = false
//        completion(false)
//      } .disposed(by: disposeBag)
//  }
//
//  func checkFavorites(id: Int, completion: @escaping (Game?) -> Void) {
//    detailUseCase.checkFavorites(id: id)
//      .observe(on: MainScheduler.instance)
//      .subscribe { result in
//        completion(result)
//      } onError: { error in
//        self.errorMessage = error.localizedDescription
//      } onCompleted: {
//      }.disposed(by: disposeBag)
//  }

}
