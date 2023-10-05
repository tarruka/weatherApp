//
//  CityWeatherViewModelTest.swift
//  WeatherAppTests
//
//  Created by Tarek Radovan on 03/10/2023.
//

import XCTest
@testable import WeatherApp

final class CityWeatherViewModelTest: XCTestCase {

  func testWeatherProperties() {
    guard let weather = Weather.mock.first else {
      return XCTFail("Unable to create the mocked Weather")
    }
  let viewModel = CityWeatherViewModel(weather: weather)
    XCTAssertEqual(viewModel.cityName, weather.cityName)
    XCTAssertEqual(viewModel.weatherId, weather.id)
    XCTAssertEqual(viewModel.weatherDescription, weather.weatherInfo.first?.weatherDescription.capitalized)
    XCTAssertEqual(viewModel.weatherCondition, weather.weatherCondition)
    XCTAssertEqual(viewModel.dayTime, weather.dayTime)
    XCTAssertEqual(viewModel.weatherIconId, weather.weatherInfo.first?.iconId)
    
    XCTAssertEqual(
      viewModel.currentTemp,
      LocalizedString.parametrizedString(
        format: "temperature_value".localized,
        params: "\(weather.main.temp)"
      )
    )
    XCTAssertEqual(viewModel.currentTemp, "\(weather.main.temp)°")
    
    XCTAssertEqual(viewModel.maxTemp,LocalizedString.parametrizedString(
      format: "max_temperature_value".localized,
      params: "\(weather.main.tempMax)"
    ))
    XCTAssertEqual(viewModel.maxTemp, "Max: \(weather.main.tempMax)°")
    
    XCTAssertEqual(viewModel.minTemp, LocalizedString.parametrizedString(
      format: "min_temperature_value".localized,
      params: "\(weather.main.tempMin)"
    ))
    XCTAssertEqual(viewModel.minTemp, "Min: \(weather.main.tempMin)°")
    
    XCTAssertEqual(viewModel.humidityShort, LocalizedString.parametrizedString(
      format: "humidity_value_short".localized,
      params: "\(weather.main.humidity)"
    ))
    XCTAssertEqual(viewModel.humidityShort, "\(weather.main.humidity)%")
    
    XCTAssertEqual(viewModel.humidityNormal, LocalizedString.parametrizedString(
      format: "humidity_value_normal".localized,
      params: "\(weather.main.humidity)"
    ))
    XCTAssertEqual(viewModel.humidityNormal, "Humidity: \(weather.main.humidity)%")
    
    XCTAssertEqual(viewModel.pressure, LocalizedString.parametrizedString(
      format: "pressure_value".localized,
      params: "\(weather.main.pressure)"
    ))
    XCTAssertEqual(viewModel.pressure, "\(weather.main.pressure) hPa")
    
    XCTAssertEqual(viewModel.latitude, "\(weather.coordinate.latitude)")
    XCTAssertEqual(viewModel.longitude, "\(weather.coordinate.longitude)")
  }
  
  func testEntityCreation() {
    let context = PersistenceController.shared.container.viewContext
    guard let weather = Weather.mock.first else {
      return XCTFail("Unable to create the mocked Weather")
    }
    let viewModel = CityWeatherViewModel(weather: weather)
    let weatherEntity = WeatherDB(context: context)
    viewModel.setValuesAtEntity(weatherEntity)
    XCTAssertEqual(weatherEntity.humidity, Int64(weather.main.humidity))
    XCTAssertEqual(weatherEntity.cityName, weather.cityName)
    XCTAssertEqual(weatherEntity.currentTemp, weather.main.temp)
    XCTAssertEqual(weatherEntity.maxTemp, weather.main.tempMax)
    XCTAssertEqual(weatherEntity.minTemp, weather.main.tempMin)
    XCTAssertEqual(weatherEntity.id, Int64(weather.id))
    XCTAssertEqual(weatherEntity.feelsLike, weather.main.feelsLike)
    XCTAssertEqual(weatherEntity.pressure, Int64(weather.main.pressure))
    XCTAssertEqual(weatherEntity.weatherDescription, weather.weatherDescription)
    XCTAssertEqual(weatherEntity.weatherCondition, weather.weatherCondition?.rawValue)
    XCTAssertEqual(weatherEntity.iconId, weather.weatherInfo.first?.iconId)
    XCTAssertEqual(weatherEntity.latitude, weather.coordinate.latitude)
    XCTAssertEqual(weatherEntity.longitude, weather.coordinate.longitude)
  }
}
