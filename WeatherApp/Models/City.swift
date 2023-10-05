//
//  City.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 29/09/2023.
//

import Foundation

struct City: Decodable {
  let id: Int
  let name: String
  let state: String
  let country: String
  let coordinates: Coordinate
  
  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case state
    case country
    case coordinates = "coord"
  }
}
