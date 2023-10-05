//
//  RotationModifier.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 01/10/2023.
//

import SwiftUI

struct RotationModifier: ViewModifier {
  @State private var rotate: Bool = false
  var animate: Bool
  func body(content: Content) -> some View {
    content
      .rotation3DEffect(rotate ? Angle(degrees: 20) : .zero, axis: (x: 0, y: 1, z: 0))
      .animation(.linear(duration: 2)
      .repeatForever(autoreverses: true), value: rotate)
      .onAppear {
        rotate = animate
      }
  }
}

extension View {
  func applyRotationEffect(animate: Bool) -> some View {
    modifier(RotationModifier(animate: animate))
  }
}
