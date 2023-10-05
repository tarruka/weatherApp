//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 30/09/2023.
//

import Foundation
import CoreLocation
import Combine

protocol LocationManagerProtocol {
  var currentLocationPublisher: AnyPublisher<CLLocationCoordinate2D, Never> { get }
}

final class LocationManager: NSObject, LocationManagerProtocol, ObservableObject {
  var currentLocationPublisher: AnyPublisher<CLLocationCoordinate2D, Never> {
    $currentLocation
      .receive(on: DispatchQueue.main)
      .compactMap({ $0 })
      .eraseToAnyPublisher()
  }
  
  static let shared = LocationManager()
  
  var locationManager: CLLocationManager?
  @Published var currentLocation: CLLocationCoordinate2D?
  
  override init() {
    super.init()
    locationManager = CLLocationManager()
    locationManager?.delegate = self
  }
  
  private func checkLocationAuthorization() {
    guard let locationManager else { return }
    
    switch locationManager.authorizationStatus {
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .restricted:
      print("Your location is restricted")
    case .denied:
      print("You have denied this app location permission, Go into settings to change it")
    case .authorizedAlways, .authorizedWhenInUse:
      guard let coordinate = locationManager.location?.coordinate else {
        return
      }
      currentLocation = coordinate
    @unknown default:
      break
      
    }
  }
}

extension LocationManager: CLLocationManagerDelegate {
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    checkLocationAuthorization()
  }
}
