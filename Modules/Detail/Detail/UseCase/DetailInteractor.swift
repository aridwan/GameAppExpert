//
//  HomeInteractor.swift
//  Home
//
//  Created by Mochammad Arief Ridwan on 14/03/23.
//

import Foundation
import RxSwift
import Common

public protocol DetailUseCase {
  func getDetailGame(game: Game) -> Observable<DetailGame>
}

public class DetailInteractor: DetailUseCase {
  
  let repository: DetailRepositoryProtocol
  var game: Game
  
  public init(repository: DetailRepositoryProtocol, game: Game) {
    self.repository = repository
    self.game = game
  }
  
  public func getDetailGame(game: Game) -> Observable<DetailGame> {
    repository.getDetailGame(game: game)
  }
  
}
