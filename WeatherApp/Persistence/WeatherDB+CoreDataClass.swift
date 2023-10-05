//
//  WeatherDB+CoreDataClass.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 02/10/2023.
//

import Foundation
import CoreData

@objc(WeatherDB)
public class WeatherDB: NSManagedObject {
  
  func transformToStruct() -> Weather? {
    guard
      let weatherConditionValue = weatherCondition,
      let weatherCondition = WeatherCondition(rawValue: weatherConditionValue),
      let weatherDescription = weatherDescription,
      let iconId = iconId,
      let cityName = cityName else {
        return nil
    }
      
    let info = WeatherInfo(
      id: .zero,
      main: weatherCondition,
      weatherDescription: weatherDescription,
      iconId: iconId
    )
    
    let mainInfo = MainInfo(
      temp: currentTemp,
      feelsLike: feelsLike,
      tempMin: minTemp,
      tempMax: maxTemp,
      pressure: Int(pressure),
      humidity: Int(humidity)
    )
    return Weather(
      id: Int(id),
      cityName: cityName,
      weatherInfo: [info],
      main: mainInfo,
      coordinate: Coordinate(latitude: latitude, longitude: longitude)
    )
  }
}
