//
//  Coordinate.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 29/09/2023.
//

import Foundation

struct Coordinate: Decodable {
  let latitude: Double
  let longitude: Double
  
  private enum CodingKeys: String, CodingKey {
    case latitude = "lat"
    case longitude = "lon"
  }
}
