//
//  CityWeatherCardView.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 30/09/2023.
//

import SwiftUI

struct CityWeatherCardView: View {
  
  @Environment(\.managedObjectContext) var context
  @FetchRequest(
    entity: WeatherDB.entity(),
    sortDescriptors: [
      NSSortDescriptor(key: "cityName", ascending: true)
    ]) private var weatherEntities: FetchedResults<WeatherDB>
  
  @ObservedObject private var viewModel: CityWeatherViewModel
  
  let removable: Bool
  var foregroundColor: Color {
    viewModel.dayTime == .day ? .black : .white
  }
  
  var blurStyle: UIBlurEffect.Style {
    viewModel.dayTime == .day ? .systemThinMaterial : .systemThinMaterialDark
  }
  
  init(viewModel: CityWeatherViewModel, removable: Bool = false) {
    self.viewModel = viewModel
    self.removable = removable
  }

  var body: some View {
    HStack(alignment: .top) {
      VStack(alignment: .center, spacing: .zero) {
        if let iconId = viewModel.weatherIconId {
          WeatherIconView(
            iconId: iconId,
            description: viewModel.weatherDescription,
            foregroundColor: foregroundColor,
            animated: false
          )
        }
      }
     
      VStack(alignment: .leading) {
        Text(viewModel.cityName)
          .font(.h2Bold)
        Text(viewModel.currentTemp)
          .font(.h5Black)
        Text(viewModel.feelsLike)
          .font(.h5Bold)
        Text(viewModel.maxTemp)
          .font(.h5Bold)
        Text(viewModel.minTemp)
          .font(.h5Bold)
        HStack {
          Image.humidityIcon
          Text(viewModel.humidityShort)
            .font(.h5Bold)
        }
      }.foregroundColor(foregroundColor)
      
      if removable {
        Button {
          withAnimation {
            deleteWeather()
          }
        } label: {
          Image.trashIcon
            .foregroundColor(foregroundColor)
        }
      }
    }
    .padding()
    .background(BlurView(style: blurStyle))
    .cornerRadius(UI.CornerRadius.medium)
    .frame(maxWidth: .infinity)
    .frame(height: UI.CityWeather.height)
    .padding(.vertical, UI.Padding.huge)
    .shadow(radius: UI.CornerRadius.medium)
  }
}

// MARK: CoreData management
extension CityWeatherCardView {
  func deleteWeather() {
    if let itemToDelete = weatherEntities.first(where: {$0.id == viewModel.weatherId}) {
      context.delete(itemToDelete)
      do {
        try context.save()
      } catch {
        print("Model couln't be saved")
      }
    }
  }
}

private extension UI {
  enum CityWeather {
    static let height: CGFloat = 150
  }
}
