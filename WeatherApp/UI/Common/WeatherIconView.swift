//
//  WeatherIconView.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 02/10/2023.
//

import SwiftUI

struct WeatherIconView: View {
  
  var iconId: String
  var description: String
  var iconSize: UI.IconSize = .medium
  var foregroundColor: Color = .black
  private var shadowColor: Color {
    foregroundColor.opacity(0.6)
  }
  var animated = true
  
  var body: some View {
    VStack(alignment: .center, spacing: .zero) {
      Image.getIcon(forId: iconId)
        .resizable()
        .frame(width: iconSize.rawValue, height: iconSize.rawValue)
      Text(description)
        .font(.h6Bold)
        .foregroundColor(foregroundColor)
    }
    .shadow(color: shadowColor, radius: UI.CornerRadius.medium)
    .applyLevitationEffect(animate: animated)
  }
}
