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

public protocol DetailRepositoryProtocol {
  func getDetailGame(game: Game) -> Observable<DetailGame>
}

public class DetailRepository: DetailRepositoryProtocol {
  
  public init() {}
  
  public func getDetailGame(game: Game) -> Observable<DetailGame> {
    let params: [String: String] = [
      "key": Constants.APIKey,
      "page": "1",
      "page_size": "15"
    ]
    return Observable<DetailGame>.create { observer in
      if let url = URL(string: "\(Endpoint.listGame)/\(game.id ?? 0)") {
        AF.request(url, parameters: params).validate().responseDecodable(of: DetailGame.self) { response in
          switch response.result {
          case .success(let value):
            observer.onNext(value)
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
