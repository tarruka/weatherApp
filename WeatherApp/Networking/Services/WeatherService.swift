//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 29/09/2023.
//

import Foundation

protocol WeatherServiceProtocol {
  func currentWeather(atCity city: City) async -> Result<Weather, NetworkingError>
  func currentWeather(atCities cities: [City]) async -> Result<[Weather], NetworkingError>
  func currentWeather(latitude: Double, longitude: Double) async -> Result<Weather, NetworkingError>
}

final class WeatherService: WeatherServiceProtocol {

  private let client: APIClient
  
  init(client: APIClient = .shared) {
    self.client = client
  }
  
  func currentWeather(atCity city: City) async -> Result<Weather, NetworkingError> {
    return await client.request(
      endpoint: WeatherEndpoint.currentWeather(cityId: city.id)
    )
  }
  
  func currentWeather(atCities cities: [City]) async -> Result<[Weather], NetworkingError> {
    ///We are using `withThrowingTaskGroup` to fetch all the cities simultaneously
    ///and then return all the array at once
    do {
      let fetchedWeathers = try await withThrowingTaskGroup(of: Weather.self) { group in
        for city in cities {
          group.addTask {
            let weather = await self.currentWeather(atCity: city)
            switch weather {
            case .success(let weather):
              return weather
            case .failure(let failure):
              throw failure
            }
            
          }
        }
        var cityWeathers = [Weather]()
        
        for try await weather in group {
          cityWeathers.append(weather)
        }
        return cityWeathers
      }
      return .success(fetchedWeathers)
    } catch {
      return .failure(.badURL)
    }
  }
  
  func currentWeather(latitude: Double, longitude: Double) async -> Result<Weather, NetworkingError> {
    return await client.request(
      endpoint: WeatherEndpoint.currentWeatherAtLocation(latitude: latitude, longitude: longitude)
    )
  }
}

