//
//  BlurView.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 02/10/2023.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
  typealias UIViewType = UIVisualEffectView
  
  let style: UIBlurEffect.Style
  
  init(style: UIBlurEffect.Style = .systemMaterial) {
    self.style = style
  }
  
  func makeUIView(context: Context) -> UIVisualEffectView {
    return UIVisualEffectView(effect: UIBlurEffect(style: self.style))
  }
  
  func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    uiView.effect = UIBlurEffect(style: self.style)
  }
}
