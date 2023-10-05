//
//  NetworkingError.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 04/10/2023.
//

import Foundation

enum NetworkingError: WeatherError {
  case objectNotFound
  case serverError
  case decodeError
  case badRequest
  case badURL
  
  var message: String {
    switch self {
    case .objectNotFound:
      return LocalizedString.NetworkingError.objectNotFoundErrorMessage
    case .serverError:
      return LocalizedString.NetworkingError.serverErrorErrorMessage
    case .decodeError:
      return LocalizedString.NetworkingError.decodeErrorErrorMessage
    case .badRequest:
      return LocalizedString.NetworkingError.badRequestErrorMessage
    case .badURL:
      return LocalizedString.NetworkingError.badURLErrorMessage
    }
  }
}

private extension LocalizedString {
  enum NetworkingError {
    static let objectNotFoundErrorMessage = "object_not_found_error_message".localized
    static let serverErrorErrorMessage = "server_error_message".localized
    static let decodeErrorErrorMessage = "decoding_error_message".localized
    static let badRequestErrorMessage = "bad_request_error_message".localized
    static let badURLErrorMessage = "bad_url_error_message".localized
  }
}
