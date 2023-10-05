//
//  LoaderView.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 01/10/2023.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
      ZStack {
        Rectangle()
          .foregroundColor(.placeholderGray)
          .opacity(UI.LoaderView.overlayOpacity)
          .luminanceToAlpha()
          .ignoresSafeArea()
        AnimatedMonoLogo()
          .shadow(color: .gray.opacity(UI.Opacity.medium), radius: UI.CornerRadius.medium)
      }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}

private extension UI {
  enum LoaderView {
    static let overlayOpacity = 0.4
  }
}
