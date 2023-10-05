//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 04/10/2023.
//

import SwiftUI

struct WeatherDetailView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject private var viewModel: CityWeatherViewModel
  @State var showCurrentTemp: Bool = false
  
  private var backButton: some View {
    Button {
      presentationMode.wrappedValue.dismiss()
    } label: {
      Image.backIcon.foregroundColor(foregroundColor)
    }
  }
  
  var foregroundColor: Color {
    viewModel.dayTime == .day ? .black : .white
  }
  
  var backgroundFilter: Color {
    viewModel.dayTime == .day ? .white : .black
  }
  
  var shadowColor: Color {
    foregroundColor.opacity(0.6)
  }
  
  init(viewModel: CityWeatherViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(alignment: .center) {
      HStack {
        Image.getIcon(forId: viewModel.weatherIconId)
          .resizable()
          .setSquaredSize(UI.WeatherDetail.imageSize)
          .shadow(color: shadowColor, radius: UI.CornerRadius.medium)
        VStack {
          Text(viewModel.currentTemp)
            .font(.h0Black)
          Text(viewModel.weatherDescription)
            .font(.h3Bold)
        }
      }
      .animation(.spring(duration: 1, bounce: 0.5), value: showCurrentTemp)
      .transition(.move(edge: .top).combined(with: .opacity))
      Text(viewModel.cityName)
        .font(.h0Black)
        .shadow(color: shadowColor, radius: UI.CornerRadius.small)
        .lineLimit(1)
        .minimumScaleFactor(0.3)
        .padding(.vertical, UI.Padding.large)
      WeatherDetailRow(key: LocalizedString.WeatherDetail.feelingTitle, value: viewModel.feelsLike)
      WeatherDetailRow(key: LocalizedString.WeatherDetail.maxTempTitle, value: viewModel.maxTemp)
      WeatherDetailRow(key: LocalizedString.WeatherDetail.minTempTitle, value: viewModel.minTemp)
      WeatherDetailRow(key: LocalizedString.WeatherDetail.humidityTitle, value: viewModel.humidityShort)
      WeatherDetailRow(key: LocalizedString.WeatherDetail.pressureTitle, value: viewModel.pressure)
      Text(LocalizedString.WeatherDetail.coordinatesTitle)
        .font(.h1Bold)
        .frame(maxWidth: .infinity, alignment: .leading)
        .shadow(color: shadowColor, radius: UI.CornerRadius.small)
        .padding(.vertical)
      WeatherDetailRow(key: LocalizedString.WeatherDetail.latitudeTitle, value: viewModel.latitude)
      WeatherDetailRow(key: LocalizedString.WeatherDetail.longitudeTitle, value: viewModel.longitude)
      Spacer()
    }
    .onAppear {
      showCurrentTemp = true
    }
    .padding()
    .foregroundColor(foregroundColor)
    .background(
      ZStack {
        viewModel.weatherCondition?.getImage(atTime: viewModel.dayTime)
          .resizable()
          .scaledToFill()
          .ignoresSafeArea()
        backgroundFilter
          .opacity(0.3)
          .ignoresSafeArea()
      }
    )
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(leading: backButton)
    
  }
}

private extension UI {
  enum WeatherDetail {
    static let imageSize: CGFloat = 130
  }
}

private extension LocalizedString {
  enum WeatherDetail {
    static let feelingTitle = "feeling_detail_title".localized
    static let maxTempTitle = "max_temp_detail_title".localized
    static let minTempTitle = "min_temp_detail_title".localized
    static let humidityTitle = "humidity_detail_title".localized
    static let pressureTitle = "pressure_detail_title".localized
    static let coordinatesTitle = "coordinates_detail_title".localized
    static let latitudeTitle = "latitude_detail_title".localized
    static let longitudeTitle = "longitude_detail_title".localized
  }
}
