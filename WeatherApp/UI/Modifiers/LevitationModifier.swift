//
//  LevitationModifier.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 01/10/2023.
//

import SwiftUI

struct LevitationModifier: ViewModifier {
  @State private var levitate: Bool = false
  var animate: Bool
  
  func body(content: Content) -> some View {
    content
      .offset(y: levitate ? 10 : -5)
      .animation(.linear(duration: 2)
      .repeatForever(autoreverses: true), value: levitate)
      .onAppear {
        levitate = animate
      }
  }
}

extension View {
  func applyLevitationEffect(animate: Bool) -> some View {
    modifier(LevitationModifier(animate: animate))
  }
}

