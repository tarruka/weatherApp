//
//  Weather.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 29/09/2023.
//

import Foundation

struct Weather: Decodable, Identifiable {
  let id: Int
  let cityName: String
  let weatherInfo: [WeatherInfo]
  let main: MainInfo
  let coordinate: Coordinate
  
  var weatherCondition: WeatherCondition? {
    weatherInfo.first?.main
  }
  
  var weatherDescription: String? {
    weatherInfo.first?.weatherDescription
  }
  
  var dayTime: DayTime? {
    guard let iconId = weatherInfo.first?.iconId else {
      return nil
    }
    if iconId.contains("d") {
      return .day
    } else {
      return .night
    }
  }
  
  private enum CodingKeys: String, CodingKey {
    case weatherInfo = "weather"
    case main
    case id
    case cityName = "name"
    case coordinate = "coord"
  }
  
  func transformToEntity(_ weatherEntity: WeatherDB) {
    weatherEntity.humidity = Int64(main.humidity)
    weatherEntity.cityName = cityName
    weatherEntity.currentTemp = main.temp
    weatherEntity.maxTemp = main.tempMax
    weatherEntity.minTemp = main.tempMin
    weatherEntity.id = Int64(id)
    weatherEntity.feelsLike = main.feelsLike
    weatherEntity.pressure = Int64(main.pressure)
    weatherEntity.weatherDescription = weatherDescription
    weatherEntity.weatherCondition = weatherCondition?.rawValue
    weatherEntity.iconId = weatherInfo.first?.iconId
    weatherEntity.latitude = coordinate.latitude
    weatherEntity.longitude = coordinate.longitude
  }
}

struct WeatherInfo: Decodable {
  let id: Int
  let main: WeatherCondition
  let weatherDescription: String
  let iconId: String
  
  private enum CodingKeys: String, CodingKey {
    case id
    case main
    case weatherDescription = "description"
    case iconId = "icon"
  }
}

struct MainInfo: Decodable {
  let temp: Double
  let feelsLike: Double
  let tempMin: Double
  let tempMax: Double
  let pressure: Int
  let humidity: Int
  
  private enum CodingKeys: String, CodingKey {
    case temp
    case feelsLike = "feels_like"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case pressure
    case humidity
  }
}
