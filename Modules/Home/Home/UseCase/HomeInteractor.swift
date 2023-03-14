//
//  HomeInteractor.swift
//  Home
//
//  Created by Mochammad Arief Ridwan on 14/03/23.
//

import Foundation
import RxSwift

public protocol HomeUseCase {
  func getGames() -> Observable<[Game]>
}

public class HomeInteractor: HomeUseCase {
  
  let repository: GameRepositoryProtocol
  
  public init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  
  public func getGames() -> Observable<[Game]> {
    repository.getGames()
  }
}
