//
//  View+extension.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 04/10/2023.
//

import Foundation
import SwiftUI

extension View {
  func setSquaredSize(_ size: CGFloat) -> some View {
    self.frame(width: size, height: size)
  }
}
