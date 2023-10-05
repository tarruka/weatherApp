//
//  WeatherDB+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 02/10/2023.
//

import Foundation
import CoreData


extension WeatherDB {

  @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherDB> {
    return NSFetchRequest<WeatherDB>(entityName: "WeatherDB")
  }

  @NSManaged public var humidity: Int64
  @NSManaged public var cityName: String?
  @NSManaged public var currentTemp: Double
  @NSManaged public var maxTemp: Double
  @NSManaged public var minTemp: Double
  @NSManaged public var latitude: Double
  @NSManaged public var longitude: Double
  @NSManaged public var id: Int64
  @NSManaged public var feelsLike: Double
  @NSManaged public var pressure: Int64
  @NSManaged public var weatherDescription: String?
  @NSManaged public var weatherCondition: String?
  @NSManaged public var iconId: String?

}

extension WeatherDB : Identifiable {}
