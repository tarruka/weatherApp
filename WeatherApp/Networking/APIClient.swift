//
//  APIClient.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 29/09/2023.
//

import Foundation

enum EncodingConfiguration {
  case httpBody
  case queryString
}

final class APIClient {
  
  init() { }
  
  func request<T: Decodable>(endpoint: Endpoint) async -> Result<T,NetworkingError> {

    guard let request = prepareRequest(endpoint: endpoint) else {
      return .failure(.badRequest)
    }

    do {
      let (data, response) = try await URLSession.shared.data(for: request)
      
      guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        return .failure(NetworkingError.badRequest)
      }
      return decode(data)
    } catch {
      return .failure(.badURL)
    }
  }
  
  private func prepareRequest(endpoint: Endpoint) -> URLRequest? {
    var urlComponents = URLComponents(
      url: endpoint.requestURL,
      resolvingAgainstBaseURL: true
    )
    if endpoint.encodingConfiguration == .queryString {
      urlComponents?.queryItems = getQueryItems(fromParams: endpoint.parameters)
    }
    
    if let requestURL = urlComponents?.url {
      var request = URLRequest(url: requestURL)
      
      endpoint.headers.forEach { key, value in
        request.setValue(value, forHTTPHeaderField: key)
      }
      
      if endpoint.encodingConfiguration == .httpBody {
        request.httpBody = endpoint.parameters.serialized
      }
      return request
    } else {
      return nil
    }
    
  }
  
  private func getQueryItems(fromParams params: [String: Any]) -> [URLQueryItem]{
    var items: [URLQueryItem] = []
    params.forEach { key, value in
      items.append(URLQueryItem(name: key, value: "\(value)"))
    }
    return items
  }
  
  private func decode<T: Decodable>(_ data: Data) -> Result<T, NetworkingError> {
    do {
      let object = try JSONDecoder().decode(T.self, from: data)
      return .success(object)
    } catch {
      return .failure(.decodeError)
    }
  }
}

