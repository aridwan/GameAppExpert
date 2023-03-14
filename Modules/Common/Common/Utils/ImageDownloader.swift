//
//  ImageDownloader.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 03/02/23.
//

import UIKit

public class ImageDownloader {
  
  public init() {}
  
  public func downloadImage(url: URL) async throws -> UIImage {
    async let imageData: Data = try Data(contentsOf: url)
    return UIImage(data: try await imageData)!
  }
}
