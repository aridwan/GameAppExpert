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
import ErrorPackage

public protocol GameRepositoryProtocol {
  func getGames() -> Observable<[Game]>
}

public class GameRepository: GameRepositoryProtocol {
  
  public init() {}
  
  public func getGames() -> Observable<[Game]> {
    let params: [String: String] = [
      "key": Constants.APIKey,
      "page": "1",
      "page_size": "15"
    ]
    return Observable<[Game]>.create { observer in
      if let url = URL(string: Endpoint.listGame) {
        AF.request(url, parameters: params).validate().responseDecodable(of: ListGame.self) { response in
          switch response.result {
          case .success(let value):
            observer.onNext(value.results ?? [Game]())
            observer.onCompleted()
          case .failure:
            observer.onError(URLError.invalidResponse)
          }
        }
      }
      return Disposables.create()
    }
  }
  
  
}
