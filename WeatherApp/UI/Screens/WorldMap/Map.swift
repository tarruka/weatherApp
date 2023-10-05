//
//  Map.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 30/09/2023.
//

import SwiftUI
import MapKit

struct Map: View {
  
  @ObservedObject private var viewModel: MapViewModel
  @Environment(\.presentationMode) var presentationMode
  
  var foregroundColor: Color {
    viewModel.dayTime == .day ? .black : .white
  }
  
  var blurStyle: UIBlurEffect.Style {
    viewModel.dayTime == .day ? .systemThinMaterial : .systemThinMaterialDark
  }
  
  init(viewModel: MapViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    ZStack(alignment: .top) {
      MapView(tappeddCoordinate: $viewModel.tappedCoordinate)
        .ignoresSafeArea()
      VStack {
        HStack(alignment: .center) {
          Spacer()
          Text(LocalizedString.Map.title)
            .multilineTextAlignment(.center)
            .font(.h4Bold)
            .foregroundColor(foregroundColor)
          Spacer()
          Button {
            presentationMode.wrappedValue.dismiss()
          } label: {
            Image.closeButton
              .resizable()
              .setSquaredSize(UI.Map.closeButonImageSize)
              .foregroundColor(foregroundColor)
              .padding()
          }
          .setSquaredSize(UI.Map.closeButtonSize)
          .contentShape(Circle())
          .shadow(radius: UI.CornerRadius.medium)
        }
        .frame(maxWidth: .infinity)
        .background(BlurView(style: blurStyle))
        if let fetchedWeather = viewModel.fetchedWeather {
          VStack {
            CityWeatherCardView(
              viewModel: CityWeatherViewModel(weather: fetchedWeather))
            Spacer()
          }
        }
      }
    }
    .showPrompt(
      show: viewModel.showErrorBinding,
      message: viewModel.errorMessage,
      style: .error
    )
    .showLoader(viewModel.isLoading)
  }
}

private extension UI {
  enum Map {
    static let closeButonImageSize: CGFloat = 25
    static let closeButtonSize: CGFloat = 44
  }
}

private extension LocalizedString {
  enum Map {
    static let title = "map_view_title".localized
  }
}
