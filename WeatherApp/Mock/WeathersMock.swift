//
//  WeathersMock.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 03/10/2023.
//

import Foundation

extension Weather {
  static var mock: [Weather] {
    guard  let weathers: [Weather] = Bundle.main.decode(file: "WeathersJsonMock.json") else {
      return []
    }
    return weathers
  }
}
