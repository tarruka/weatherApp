//
//  File.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 29/09/2023.
//

import Foundation
import SwiftUI

enum Constants {
  static let apiKey: String = "060be43f91ac73075520443bf1e3165e"
}

enum UI {
  enum Padding {
    static let tiny: CGFloat = 5
    static let small: CGFloat = 10
    static let medium: CGFloat = 20
    static let large: CGFloat = 30
    static let huge: CGFloat = 40
  }
  
  enum CornerRadius {
    static let small: CGFloat = 5
    static let medium: CGFloat = 10
    static let large: CGFloat = 20
  }
  
  enum IconSize: CGFloat {
    case large = 150
    case medium = 120
    case small = 80
  }
  
  enum Opacity {
    static let translucent: CGFloat = 0
    static let almostTranslucent: CGFloat = 0.3
    static let medium: CGFloat = 0.5
    static let almostOpaque: CGFloat = 0.8
    static let opaque: CGFloat = 1
  }
}
