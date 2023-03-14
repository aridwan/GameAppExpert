//
//  Restaurant.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 26/01/23.
//

import Foundation
import UIKit

public enum DownloadState {
  case new, downloaded, failed
}

// MARK: - ListGame
public struct ListGame: Decodable {
  var count: Int?
  var next: String?
  var previous: JSONNull?
  public var results: [Game]?
  var seoTitle, seoDescription, seoKeywords, seoH1: String?
  var description: String?
  
  enum CodingKeys: String, CodingKey {
    case count, next, previous, results
    case seoTitle = "seo_title"
    case seoDescription = "seo_description"
    case seoKeywords = "seo_keywords"
    case seoH1 = "seo_h1"
    case description
  }
}

// MARK: - Result
public class Game: Decodable {
  public var id: Int?
  public var slug, name, released: String?
  public var backgroundImage: String?
  public var rating: Double?
  public var added: Int?
  public var reviewsCount: Int?
  public var parentPlatforms: [ParentPlatform]?
  public var esrbRating: EsrbRating?
  public var shortScreenshots: [ShortScreenshot]?
  public var descriptionRaw: String?
  public var state: DownloadState = .new
  public var savedImage: Data?
  public var image: UIImage?
  
  init(id: Int, name: String, releasedDate: String, rating: Double, added: Int, esrbRating: String, descriptionRaw: String, backgroundImage: String, savedImage: Data) {
    self.id = id
    self.name = name
    self.released = releasedDate
    self.rating = rating
    self.added = added
    self.esrbRating = EsrbRating(id: 0, name: Name.init(rawValue: esrbRating), slug: Slug.init(rawValue: esrbRating))
    self.descriptionRaw = descriptionRaw
    self.backgroundImage = backgroundImage
    self.savedImage = savedImage
  }
  
  enum CodingKeys: String, CodingKey {
    case id, slug, name, released
    case backgroundImage = "background_image"
    case rating
    case added
    case reviewsCount = "reviews_count"
    case parentPlatforms = "parent_platforms"
    case esrbRating = "esrb_rating"
    case shortScreenshots = "short_screenshots"
  }
}

public enum Color: String, Codable {
  case the0F0F0F = "0f0f0f"
}

// MARK: - EsrbRating
public struct EsrbRating: Codable {
  public var id: Int?
  public var name: Name?
  public var slug: Slug?
}

public enum Name: String, Codable {
  case adultsOnly = "Adults Only"
  case android = "Android"
  case appleMacintosh = "Apple Macintosh"
  case everyone = "Everyone"
  case everyone10 = "Everyone 10+"
  case iOS = "iOS"
  case linux = "Linux"
  case mature = "Mature"
  case nintendo = "Nintendo"
  case pc = "PC"
  case playStation = "PlayStation"
  case teen = "Teen"
  case web = "Web"
  case xbox = "Xbox"
}

public enum Slug: String, Codable {
  case adultsOnly = "adults-only"
  case android = "android"
  case everyone = "everyone"
  case everyone10Plus = "everyone-10-plus"
  case ios = "ios"
  case linux = "linux"
  case mac = "mac"
  case mature = "mature"
  case nintendo = "nintendo"
  case pc = "pc"
  case playstation = "playstation"
  case teen = "teen"
  case web = "web"
  case xbox = "xbox"
}

// MARK: - ParentPlatform
public struct ParentPlatform: Codable {
  public var platform: EsrbRating?
}

// MARK: - ShortScreenshot
public struct ShortScreenshot: Codable {
  public var id: Int?
  public var image: String?
}

// MARK: - Encode/decode helpers

public class JSONNull: Codable, Hashable {
  
  public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
    return true
  }
  
  public func hash(into hasher: inout Hasher) {
  }
  
  public init() {}
  
  public required init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if !container.decodeNil() {
      throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encodeNil()
  }
}
