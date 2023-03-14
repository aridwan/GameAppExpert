//
//  GameRepository.swift
//  Home
//
//  Created by Mochammad Arief Ridwan on 14/03/23.
//

import Foundation
import RxSwift
import Alamofire
import Common

public protocol FavoriteRepositoryProtocol {
  func getFavorites() -> Observable<[Game]>
}

public class FavoritesRepository: FavoriteRepositoryProtocol {
  
  public var favoritesProvider = FavoritesProvider()
  public init() {}
  
  public func getFavorites() -> Observable<[Game]> {
    favoritesProvider.getAllFavorites()
  }
  
}
