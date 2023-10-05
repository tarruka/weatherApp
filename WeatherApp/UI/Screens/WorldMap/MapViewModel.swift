//
//  MapViewModel.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 30/09/2023.
//

import CoreLocation
import Combine
import SwiftUI


final class MapViewModel: NSObject, ObservableObject {
  
  @MainActor @Published var tappedCoordinate: CLLocationCoordinate2D?
  @Published var fetchedWeather: Weather?
  @Published var isLoading = false
  
  var locationManager: LocationManager?

  var showErrorBinding: Binding<Bool> {
    errorHandler.showErrorBinding
  }
  var errorMessage: String {
    errorHandler.errorMessage
  }
  
  let dayTime: DayTime
  private let errorHandler: ErrorHandlerProtocol
  private let weatherService: WeatherServiceProtocol
  private var cancelBag = Set<AnyCancellable>()
  
  init(
    dayTime: DayTime,
    locationManager: LocationManager = .shared,
    weatherService: WeatherServiceProtocol,
    errorHandler: ErrorHandlerProtocol = ErrorHandler()
  ) {
    self.dayTime = dayTime
    self.errorHandler = errorHandler
    self.weatherService = weatherService
    super.init()
    self.locationManager = locationManager
    
    $tappedCoordinate
      .receive(on: DispatchQueue.main)
      .sink { [weak self] location in
        guard
          let self,
          let latitude = location?.latitude,
          let longitude = location?.longitude
        else {
          return
        }
        Task {
          await self.fetchWeatherAt(latitude: latitude, longitude: longitude)
        }
      }.store(in: &cancelBag)
  }
  
  @MainActor
  func fetchWeatherAt(latitude: Double, longitude: Double) {
    isLoading = true
    Task {
      let weatherResult = await weatherService.currentWeather(latitude: latitude, longitude: longitude)
      
      switch weatherResult {
      case .success(let weather):
        self.fetchedWeather = weather
      case .failure(let error):
        errorHandler.receiveError(error)
      }
      isLoading = false
    }
    
  }
}
