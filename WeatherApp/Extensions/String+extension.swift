//
//  String+extension.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 04/10/2023.
//

import Foundation

extension String {
  
  var localized: String {
    localize()
  }
  
  func localize(comment: String = "") -> String {
    NSLocalizedString(self, comment: comment)
  }
  
  func localized(_ args: CVarArg...) -> String {
    String(format: localized, arguments: args)
  }
}
