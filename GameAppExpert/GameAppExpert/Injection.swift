//
//  Injection.swift
//  GameAppExpert
//
//  Created by Mochammad Arief Ridwan on 14/03/23.
//

import Foundation
import Home
import Detail
import About
import Favorite

final class Injection: NSObject {
 
  private func provideRepository() -> GameRepositoryProtocol {
    let remote = GameRepository()
    return remote
  }
 
  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }
  
  func provideFavorite() -> FavoriteUseCase {
    let repository = FavoritesRepository()
    return FavoriteInteractor(repository: repository)
  }
  
//  func provideDetail(game: Game) -> DetailUseCase {
//    let repository = provideRepository()
//    return DetailInteractor(repository: repository, game: game)
//  }

}
