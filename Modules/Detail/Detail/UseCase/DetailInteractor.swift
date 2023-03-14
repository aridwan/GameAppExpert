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
  func setFavorites(game: Game, image: Data) -> Observable<Bool>
  func removeFavorites(game: Game) -> Observable<Bool>
  func checkFavorites(id: Int) -> Observable<Game>
}

public class DetailInteractor: DetailUseCase {
  
  let repository: DetailRepositoryProtocol
  let favoritesProvider = FavoritesProvider()
  var game: Game
  
  public init(repository: DetailRepositoryProtocol, game: Game) {
    self.repository = repository
    self.game = game
  }
  
  public func getDetailGame(game: Game) -> Observable<DetailGame> {
    repository.getDetailGame(game: game)
  }
  
  public func setFavorites(game: Game, image: Data) -> Observable<Bool> {
    favoritesProvider.createFavorites(id: game.id ?? 0,
                                      name: game.name ?? "",
                                      releasedDate: game.released ?? "",
                                      rating: game.rating ?? 0,
                                      added: game.added ?? 0,
                                      esrbRating: game.esrbRating?.name?.rawValue ?? "",
                                      descriptionRaw: game.descriptionRaw ?? "",
                                      backgroundImage: game.backgroundImage ?? "",
                                      image: image)
  }
  
  public func removeFavorites(game: Game) -> Observable<Bool> {
    favoritesProvider.deleteFavorites(game.id ?? 0)
  }

  public func checkFavorites(id: Int) -> Observable<Game> {
    favoritesProvider.getGame(by: id)
  }
}
