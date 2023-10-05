//
//  SplashView.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 02/10/2023.
//

import SwiftUI

struct SplashView: View {
  var body: some View {
    VStack {
      Image.weatherSmallIcon
        .shadow(color: .gray.opacity(UI.Opacity.medium), radius: UI.CornerRadius.medium)
        .applyScaleEffect(animate: true)
    }.background(Color.white)
  }
}
