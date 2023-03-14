//
//  Injection.swift
//  Home
//
//  Created by Mochammad Arief Ridwan on 14/03/23.
//

import Foundation
import Detail
import Common

public final class HomeInjection: NSObject {
  
  private func provideRepository() -> DetailRepositoryProtocol {
    let remote = DetailRepository()
    return remote
  }
  
  func provideDetail(game: Game) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository, game: game)
  }
  
}
