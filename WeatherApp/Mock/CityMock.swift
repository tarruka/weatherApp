//
//  CityMock.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 03/10/2023.
//

import Foundation

extension City {
  static var mock: [City] {
    return CitiesService().getPreferredCities()
  }
}
