//
//  LocationManagerMock.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 03/10/2023.
//

import Foundation
import CoreLocation
import Combine

final class LocationManagerMock: LocationManagerProtocol {
  static let shared = LocationManagerMock()
  var currentLocationPublisher: AnyPublisher<CLLocationCoordinate2D, Never> {
    $currentLocation
      .receive(on: DispatchQueue.main)
      .compactMap({$0})
      .eraseToAnyPublisher()
  }
  @Published var currentLocation: CLLocationCoordinate2D?
  
  init() {}
  
  func simulateLocation() {
    // London location mocked
    currentLocation = CLLocationCoordinate2D(latitude: 51.5085, longitude: -0.1257)
  }
}
