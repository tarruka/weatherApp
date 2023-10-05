//
//  CitiesService.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 29/09/2023.
//

import Foundation

/// This service is mocked, assuming that we have our own API service to fetch city information such as ID or correct name, which is necessary for fetching weather data

protocol CitiesServcieProtocol {
  func getPreferredCities() -> [City]
}

class CitiesService: CitiesServcieProtocol {
  
  func getPreferredCities() -> [City] {
    guard
      let cities: [City] = Bundle.main.decode(file: "PreferredCities.json") else {
      return []
    }
    return cities
  }
}

extension Bundle {
  func decode<T: Decodable>(file: String) -> T? {
    guard let url = self.url(forResource: file, withExtension: nil) else {
      print("Could not find \(file) in the project")
      return nil
    }
    
    guard let data = try? Data(contentsOf: url) else {
      print("Could not load \(file) in the project")
      return nil
    }
    
    guard let loadedData = try? JSONDecoder().decode(T.self, from: data) else {
      print("Could not decode \(file) in the project")
      return nil
    }
    return loadedData
  }
}
