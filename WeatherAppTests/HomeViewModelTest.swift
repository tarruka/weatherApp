//
//  HomeViewModelTest.swift
//  WeatherAppTests
//
//  Created by Tarek Radovan on 03/10/2023.
//

import XCTest
@testable import WeatherApp
import Combine

final class HomeViewModelTest: XCTestCase {

  func testErrorHandler() {
    var cancelBag = Set<AnyCancellable>()
    
    let viewModel = HomeViewModel(
      service: WeatherServiceMock(),
      locationManager: LocationManagerMock.shared
    )

    let expectation = XCTestExpectation(description: "Location is the expected one that we mocked it in the LocationManagerMock")
  

    print(NetworkingError.decodeError.message)
    
    viewModel.$currentWeather
      .dropFirst()
      .sink { weather in
        XCTAssertEqual(weather?.id, 2643743) // London
        expectation.fulfill()
      }.store(in: &cancelBag)
    
    LocationManagerMock.shared.simulateLocation()
    wait(for: [expectation], timeout: 1)
  }
}
