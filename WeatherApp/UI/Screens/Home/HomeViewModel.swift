//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 30/09/2023.
//

import CoreLocation
import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
  
  @MainActor @Published var isLoading: Bool = false
  @Published var citiesWeathers: [Weather] = []
  @Published var currentWeather: Weather?

  var currentWeatherCondition: WeatherCondition? {
    currentWeather?.weatherInfo.first?.main
  }
  
  var dayTime: DayTime {
    currentWeather?.dayTime ?? .day
  }
  
  var showErrorBinding: Binding<Bool> {
    errorHandler.showErrorBinding
  }
  var errorMessage: String {
    errorHandler.errorMessage
  }
  
  private let service: WeatherServiceProtocol
  private let locationManager: LocationManagerProtocol
  private let errorHandler: ErrorHandlerProtocol
  private var preferredCities = [City]()
  private var cancelBag = Set<AnyCancellable>()
  
  init(
    service: WeatherServiceProtocol = WeatherService(),
    citiesService: CitiesServcieProtocol = CitiesService(),
    locationManager: LocationManagerProtocol = LocationManager.shared,
    errorHandler: ErrorHandlerProtocol = ErrorHandler()
  ) {
    self.errorHandler = errorHandler
    self.locationManager = locationManager
    self.preferredCities = citiesService.getPreferredCities()
    self.service = service
    
    locationManager.currentLocationPublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] location in
        guard let self else { return }
        Task {
          await self.fetchCurrentWeather(latitude: location.latitude, longitude: location.longitude)
        }
      }.store(in: &cancelBag)
  }
  
  func getMapViewModel() -> MapViewModel {
    return MapViewModel(
      dayTime: dayTime,
      weatherService: service
    )
  }
  
  @MainActor
  func fetchPreferredCities() {
    isLoading = true
    Task {
      let preferredCitiesWeather = await service.currentWeather(atCities: preferredCities)
      switch preferredCitiesWeather {
      case .success(let weathers):
        self.citiesWeathers = weathers
      case .failure(let failure):
        print(failure)
      }
      isLoading = false
    }
  }
  
  func fetchWeatherAt(latitude: Double, longitude: Double) async -> Result<Weather, NetworkingError> {
    return await service.currentWeather(latitude: latitude, longitude: longitude)
  }
 
  @MainActor
  func fetchCurrentWeather(latitude: Double, longitude: Double) {
    Task {
      let currentWeather = await fetchWeatherAt(latitude: latitude, longitude: longitude)
      switch currentWeather {
      case .success(let currentWeather):
        self.currentWeather = currentWeather
      case .failure(let error):
        errorHandler.receiveError(error)
      }
    }
  }
}
