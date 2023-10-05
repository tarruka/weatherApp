//
//  Dictionary+extension.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 30/09/2023.
//

import Foundation

extension Dictionary {
  var serialized: Data? {
    if let data = try? JSONSerialization.data(withJSONObject: self) {
      return data
    } else {
      print("Unable to serialize dictionary \(self)")
      return nil
    }
  }
}
