//
//  Endpoint.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 29/09/2023.
//

import Foundation

enum HTTPMethod: String {
  case post = "POST"
  case get = "GET"
  case patch = "PATCH"
  case put = "PUT"
  case delete = "DELETE"
}

protocol Endpoint {
  var requestURL: URL { get }
  var path: String { get }
  var baseURL: String { get }
  var method: HTTPMethod { get }
  var headers: [String: String] { get }
  var parameters: [String: Any] { get }
  var encodingConfiguration: EncodingConfiguration { get }
}

extension Endpoint {
  var baseURL: String {
    return Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String ?? ""
  }
  
  var requestURL: URL {
    guard let requestURL = URL(string: baseURL)?.appendingPathComponent(path) else {
      fatalError("URL for endpoint at \(path) could not be constructed")
    }
    return requestURL
  }
}
