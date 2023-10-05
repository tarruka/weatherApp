//
//  ScaleModifier.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 02/10/2023.
//

import SwiftUI

import SwiftUI

struct ScaleModifier: ViewModifier {
  @State private var scale: Bool = false
  var animate: Bool
  func body(content: Content) -> some View {
    content
      .scaleEffect(scale ? 2.3 : 3)
      .animation(.linear(duration: 4)
      .repeatForever(autoreverses: true), value: scale)
      .onAppear {
        scale = animate
      }
  }
}

extension View {
  func applyScaleEffect(animate: Bool) -> some View {
    modifier(ScaleModifier(animate: animate))
  }
}
