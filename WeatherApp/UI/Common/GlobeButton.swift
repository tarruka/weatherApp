//
//  GlobeButton.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 02/10/2023.
//

import SwiftUI

struct GlobeButton: View {
  
  var dayTime: DayTime = .day
  var onPress: () -> Void
  
  var body: some View {
    Button(action: {
      onPress()
    }, label: {
      Image.globe
        .resizable()
        .frame(
          width: UI.IconSize.small.rawValue,
          height: UI.IconSize.small.rawValue
        )
        .foregroundColor(dayTime == .day ? .blue : .yellow)
        .padding(UI.Padding.tiny)
        .background(
          Circle()
            .foregroundColor(dayTime == .day ? .white : .black)
            .shadow(
              color: dayTime == .day ? .black.opacity(UI.GlobeButton.buttonBackgroundOpacity) : .yellow.opacity(UI.GlobeButton.buttonBackgroundOpacity),
              radius: UI.CornerRadius.large
            )
        )
    }).applyRotationEffect(animate: true)
  }
}

private extension UI {
  enum GlobeButton {
    static let buttonBackgroundOpacity: CGFloat = 0.4
  }
}
