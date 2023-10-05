//
//  WeatherConditions.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 30/09/2023.
//

import Foundation
import SwiftUI

enum DayTime {
  case night
  case day
}

enum WeatherCondition: String, Decodable {
  case mist = "Mist"
  case haze = "Haze"
  case fog = "Fog"
  case sand = "Sand"
  case dust = "Dust"
  case ash = "Ash"
  case squall = "Squall"
  case tornado = "Tornado"
  case snow = "Snow"
  case rain = "Rain"
  case drizzle = "Drizzle"
  case thunderstorm = "Thunderstorm"
  case clear = "Clear"
  case clouds = "Clouds"
  
  func getImage(atTime time: DayTime) -> Image {
    switch self {
    case .mist:
      return Image.mistWeather
    case .haze:
      return Image.hazeWeather
    case .dust:
      return Image.dustWeather
    case .fog:
      return Image.fogWeather
    case .sand:
      return Image.sandWeather
    case .ash:
      return Image.ashWeather
    case .squall:
      return Image.squallWeather
    case .tornado:
      return Image.tornadoWeather
    case .snow:
      return Image.snowWeather
    case .rain:
      if time == .day {
        return Image.dayRainWeather
      } else {
        return Image.nightRainWeather
      }
    case .drizzle:
      return Image.drizzleWeather
    case .thunderstorm:
      return Image.thunderstormWeather
    case .clear:
      if time == .day {
        return Image.clearDayWeather
      } else {
        return Image.clearNightWeather
      }
    case .clouds:
      if time == .day {
        return Image.dayCloudsWeather
      } else {
        return Image.nightCloudsWeather
      }
    }
  }
}
