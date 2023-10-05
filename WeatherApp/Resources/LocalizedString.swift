//
//  LocalizedString.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 04/10/2023.
//

import Foundation

enum LocalizedString {
  enum Common {
    static let exampleTitle = "example_title".localized
  }
}

extension LocalizedString {
  /// A function to create a String with format and multiple parameters
  /// - Parameters:
  ///   - format: The base string with format that needs to be replaced with params. Ex: "Welcome %@"
  ///   - params: Parameters that needs to be replaced in base string. Ex: "username".
  /// - Returns: A custom String with params included. Ex: "Welcome username"
  static func parametrizedString(format: String, params: String...) -> String {
    String(format: format, arguments: params)
  }
}

