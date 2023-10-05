//
//  Endpoints.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 29/09/2023.
//

import Foundation

enum WeatherEndpoint: Endpoint {
  case currentWeather(cityId: Int)
  case currentWeatherAtLocation(latitude: Double, longitude: Double)
  
  var path: String {
    switch self {
    case .currentWeather, .currentWeatherAtLocation:
      return "/weather"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .currentWeather, .currentWeatherAtLocation:
      return .get
    }
  }
  
  var headers: [String : String] {
    return [:]
  }
  
  var parameters: [String : Any] {
    switch self {
    case .currentWeather(let cityId):
      return [
        "id" : cityId,
        "units": "metric",
        "appid" : Constants.apiKey
      ]
    case .currentWeatherAtLocation(let latitude, let longitude):
      return [
        "lat": latitude,
        "lon": longitude,
        "units": "metric",
        "appid" : Constants.apiKey
      ]
    }
  }
  var encodingConfiguration: EncodingConfiguration {
    switch self {
    case .currentWeather, .currentWeatherAtLocation:
      return .queryString
    }
  }
}
