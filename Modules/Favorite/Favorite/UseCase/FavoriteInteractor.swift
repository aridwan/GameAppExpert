//
//  HomeInteractor.swift
//  Home
//
//  Created by Mochammad Arief Ridwan on 14/03/23.
//

import Foundation
import RxSwift
import Common

public protocol FavoriteUseCase {
  func getFavorites() -> Observable<[Game]>
}

public class FavoriteInteractor: FavoriteUseCase {
  
  let repository: FavoriteRepositoryProtocol
  
  public init(repository: FavoriteRepositoryProtocol) {
    self.repository = repository
  }
  
  public func getFavorites() -> Observable<[Game]> {
    repository.getFavorites()
  }
}
