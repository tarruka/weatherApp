//
//  CityWeatherViewModel.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 30/09/2023.
//

import Foundation
import SwiftUI

class CityWeatherViewModel: ObservableObject {

  private let weather: Weather
  
  var cityName: String {
    weather.cityName
  }
  
  var weatherId: Int {
    weather.id
  }
  
  var weatherDescription: String {
    weather.weatherInfo.first?.weatherDescription.capitalized ?? ""
  }
  
  var weatherCondition: WeatherCondition? {
    weather.weatherCondition
  }
  
  var dayTime: DayTime {
    weather.dayTime ?? .day
  }
  
  var weatherIconId: String? {
    weather.weatherInfo.first?.iconId
  }
  
  var currentTemp: String {
    LocalizedString.parametrizedString(
      format: LocalizedString.CityWeather.currentTemperatureValue,
      params: "\(weather.main.temp)"
    )
    
  }
  
  var maxTemp: String {
    LocalizedString.parametrizedString(
      format: LocalizedString.CityWeather.maxTemperatureValue,
      params: "\(weather.main.tempMax)"
    )
  }
  
  var minTemp: String {
    LocalizedString.parametrizedString(
      format: LocalizedString.CityWeather.minTemperatureValue,
      params: "\(weather.main.tempMin)"
    )
  }
  
  var humidityShort: String {
    LocalizedString.parametrizedString(
      format: LocalizedString.CityWeather.humidityShortValue,
      params: "\(weather.main.humidity)"
    )
  }
  
  var pressure: String {
    LocalizedString.parametrizedString(
      format: LocalizedString.CityWeather.pressureValue,
      params: "\(weather.main.pressure)"
    )
  }
  
  var latitude: String {
    "\(weather.coordinate.latitude)"
  }
  
  var longitude: String {
    "\(weather.coordinate.longitude)"
  }
  
  var humidityNormal: String {
    LocalizedString.parametrizedString(
      format: LocalizedString.CityWeather.humidityNormalValue,
      params: "\(weather.main.humidity)"
    )
  }
  
  var feelsLike: String {
    LocalizedString.parametrizedString(
      format: LocalizedString.CityWeather.feelsLikeTemperatureValue,
      params: "\(weather.main.feelsLike)"
    )
  }
  
  init(weather: Weather) {
    self.weather = weather
  }
  
  func setValuesAtEntity(_ weatherEntity: WeatherDB) {
    weather.transformToEntity(weatherEntity)
  }
}

extension LocalizedString {
  enum CityWeather {
    static let maxTemperatureValue = "max_temperature_value".localized
    static let minTemperatureValue = "min_temperature_value".localized
    static let currentTemperatureValue = "temperature_value".localized
    static let humidityShortValue = "humidity_value_short".localized
    static let humidityNormalValue = "humidity_value_normal".localized
    static let feelsLikeTemperatureValue = "feels_like_temperature_value".localized
    static let pressureValue = "pressure_value".localized
  }
}
