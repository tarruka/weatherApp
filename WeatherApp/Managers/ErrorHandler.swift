//
//  ErrorHandler.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 01/10/2023.
//

import SwiftUI
import Combine

protocol WeatherError: Error {
  var message: String { get }
}

protocol ErrorHandlerProtocol: AnyObject {
  /// A string that represents the error message
  var errorMessage: String { get }
  
  /// A publisher that emits a boolean value indicating whether to show the error or not.
  var showErrorPublisher: AnyPublisher<Bool, Never> { get }
  
  /// A binding that can be used to bind the show error state to a view.
  var showErrorBinding: Binding<Bool> { get }
  
  /// A function to receive and process an Error object.
  func receiveError(_ error: WeatherError)
  
  /// A function to receive and process an error message string.
  func receiveErrorMessage(_ errorMessage: String)
}

final class ErrorHandler: ErrorHandlerProtocol {
 
  @Published private(set) var errorMessage: String = "" {
    didSet {
      self.errorReceived = !errorMessage.isEmpty
    }
  }
  
  @Published private var errorReceived: Bool = false
  
  var showErrorPublisher: AnyPublisher<Bool, Never> {
    /// Transforms the error message publisher to a boolean publisher and emits it on the main thread.
    return $errorReceived
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  /// Responsible for presenting an error message when it exists. If its set to false by the binding in the view, it sets the errorMessage to an empty string.
  var showErrorBinding: Binding<Bool> {
    Binding(
      /// Returns a boolean value indicating whether the error message is not empty.
      get: {
        return self.errorReceived
      },
      /// Sets the error message to an empty string when the binding is set to false.
      set: {
        if $0 == false {
          self.errorMessage = ""
        }
      })
  }
  
  /// A function to receive and process an Error as `WeatherError` object.
  func receiveError(_ error: WeatherError) {
    /// Sets the error message to the message from the `WeatherError` object.
    errorMessage = error.message
  }
  
  /// A function to receive and process an error message string.
  func receiveErrorMessage(_ errorMessage: String) {
    /// Sets the error message to the provided error message string.
    self.errorMessage = errorMessage
  }
}
