//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 30/09/2023.
//

import SwiftUI

struct CurrentWeatherView: View {
  
  @Environment(\.managedObjectContext) private var context
  
  @FetchRequest(
    entity: WeatherDB.entity(),
    sortDescriptors: [
      NSSortDescriptor(key: "cityName", ascending: true)
    ]) var weatherEntities: FetchedResults<WeatherDB>
  
  var currentWeatherIsFavorite: Bool {
    !weatherEntities
      .compactMap({ $0.transformToStruct() })
      .filter({ $0.id == viewModel.weatherId}).isEmpty
  }
  
  @ObservedObject private var viewModel: CityWeatherViewModel
  @State var rotate = false
  
  var foregroundColor: Color {
    viewModel.dayTime == .day ? .black : .white
  }

  init(viewModel: CityWeatherViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    ZStack(alignment: .top) {
      HStack(alignment: .center, spacing: UI.Padding.small) {
        VStack(alignment: .leading, spacing: .zero) {
          Text(viewModel.cityName)
            .font(.h2Black)
          Text(viewModel.currentTemp)
            .font(.h0Black)
          Text(viewModel.feelsLike)
            .font(.h5Bold)
          HStack {
            Text(viewModel.maxTemp)
              .font(.h5Bold)
            Text(viewModel.minTemp)
              .font(.h5Bold)
          }
          HStack {
            Image.humidityIcon
              .resizable()
              .setSquaredSize(UI.CurrentWeather.humidityIconSize)
            Text(viewModel.humidityNormal)
              .font(.h5Bold)
          }
        }.foregroundColor(foregroundColor)
        if let iconId = viewModel.weatherIconId {
          WeatherIconView(
            iconId: iconId,
            description: viewModel.weatherDescription,
            iconSize: .large,
            foregroundColor: foregroundColor
          )
        }
      }
      HStack {
        Spacer()
        Button {
          withAnimation {
            if currentWeatherIsFavorite {
              deleteWeather()
            } else {
              saveWeather()
            }
          }
        } label: {
          Image.getHeart(filled: currentWeatherIsFavorite)
            .resizable()
            .frame(
              width: UI.CurrentWeather.heartSize,
              height: UI.CurrentWeather.heartSize
            ).foregroundColor(.red)
        }
      }
    }
    .frame(height: UI.CurrentWeather.viewHeight)
    .frame(maxWidth: .infinity)
    .padding()
  }
}

// MARK: CoreData management
extension CurrentWeatherView {
  func saveWeather() {
    if !currentWeatherIsFavorite {
      viewModel.setValuesAtEntity(WeatherDB(context: context))
      saveContext()
    }
  }
  
  func deleteWeather() {
    if let itemToDelete = weatherEntities.first(where: {$0.id == viewModel.weatherId}) {
      context.delete(itemToDelete)
      saveContext()
    }
  }
  
  func saveContext() {
    do {
      try context.save()
    } catch {
      print("Model coulnt be saved")
    }
  }
}


private extension UI {
  enum CurrentWeather {
    static let viewHeight: CGFloat = 200
    static let heartSize: CGFloat = 30
    static let humidityIconSize: CGFloat = 15
  }
}
