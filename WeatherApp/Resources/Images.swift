//
//  Images.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 29/09/2023.
//

import Foundation
import SwiftUI

extension Image {
  static let mistWeather = Image("mist")
  static let hazeWeather = Image("haze")
  static let fogWeather = Image("fog")
  static let sandWeather = Image("sand")
  static let dustWeather = Image("dust")
  static let ashWeather = Image("ash")
  static let squallWeather = Image("squall")
  static let tornadoWeather = Image("tornado")
  static let snowWeather = Image("snow")
  static let dayRainWeather = Image("day-rain")
  static let nightRainWeather = Image("night-rain")
  static let drizzleWeather = Image("drizzle")
  static let thunderstormWeather = Image("thunderstorm")
  static let clearDayWeather = Image("clear-day")
  static let clearNightWeather = Image("clear-night")
  static let dayCloudsWeather = Image("day-clouds")
  static let nightCloudsWeather = Image("night-clouds")
  static let imagePlaceholder = Image(systemName: "photo.fill")
  static let topMask = Image("top-mask")
  static let bottomMask = Image("bottom-mask")
  static let globe = Image(systemName: "globe.americas.fill")
  static let promptError = Image(systemName: "xmark.circle.fill")
  static let promptWarning = Image(systemName: "exclamationmark.circle.fill")
  static let promptSuccess = Image(systemName: "checkmark.circle.fill")
  static let weatherSmallIcon = Image("weather-splash-icon")
  static let monoLogoMain = Image("mono-main")
  static let monoLogoFirstDot = Image("mono-1")
  static let monoLogoSecondDot = Image("mono-2")
  static let monoLogoThirdDot = Image("mono-3")
  static let humidityIcon = Image(systemName: "humidity.fill")
  static let trashIcon = Image(systemName: "trash.fill")
  static let closeButton = Image(systemName: "xmark.circle.fill")
  static let filledHeartIcon = Image(systemName: "heart.fill")
  static let heartIcon = Image(systemName: "heart")
  static let backIcon = Image(systemName: "arrow.backward")
  
  static func getIcon(forId id: String?) -> Image {
    Image(id ?? "")
  }
  
  static func getHeart(filled: Bool = false) -> Image {
    filled ? .filledHeartIcon : .heartIcon
  }
}
