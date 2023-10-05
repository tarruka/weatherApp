//
//  WeatherServiceMock.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 03/10/2023.
//

import Foundation

final class WeatherServiceMock: WeatherServiceProtocol {

  func currentWeather(atCity city: City) async -> Result<Weather, NetworkingError> {
    if let weather = Weather.mock.first(where: { city.id == $0.id }) {
      return .success(weather)
    } else {
      return .failure(.badRequest)
    }
  }
  
  func currentWeather(atCities cities: [City]) async -> Result<[Weather], NetworkingError> {
    return .failure(.serverError)
  }
  
  func currentWeather(latitude: Double, longitude: Double) async -> Result<Weather, NetworkingError> {
    if let montevideoWeather = Weather.mock.first(where: { $0.coordinate.latitude == latitude && $0.coordinate.longitude == longitude}) {
      return .success(montevideoWeather)
    } else {
      return .failure(.objectNotFound)
    }
  }
}

