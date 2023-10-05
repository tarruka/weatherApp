//
//  HomeView.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 30/09/2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
  
  @FetchRequest(
    entity: WeatherDB.entity(),
    sortDescriptors: [
      NSSortDescriptor(key: "cityName", ascending: true)
    ]) private var weatherEntities: FetchedResults<WeatherDB>
  
  var savedWeathers: [Weather] {
    weatherEntities.compactMap({ $0.transformToStruct() })
  }
  
  @ObservedObject var viewModel: HomeViewModel
  @State private var presentMap: Bool = false
  @State private var selectedWeatherId: Int?
  
  var foregroundColor: Color {
    viewModel.dayTime == .day ? .black : .white
  }
  
  var backgroundFilter: Color {
    viewModel.dayTime == .day ? .white : .black
  }
  
  init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    if let currentWeather = viewModel.currentWeather {
      ZStack {
        NavigationView {
          ScrollView(.vertical) {
            VStack {
              CurrentWeatherView(viewModel: CityWeatherViewModel(weather: currentWeather))
              
              if !savedWeathers.isEmpty {
                WeathersListView(
                  weathers: savedWeathers,
                  title: LocalizedString.Home.favoriteWeathersListTitle,
                  foregroundColor: foregroundColor,
                  removableItems: true,
                  selectedWeatherId: $selectedWeatherId
                )
              }
              
              if !viewModel.citiesWeathers.isEmpty {
                WeathersListView(
                  weathers: viewModel.citiesWeathers,
                  title: LocalizedString.Home.someWeathersListTitle,
                  foregroundColor: foregroundColor,
                  removableItems: false,
                  selectedWeatherId: $selectedWeatherId
                )
              }
              Spacer()
            }
          }
          .background(
            ZStack {
              viewModel.currentWeatherCondition?.getImage(atTime: viewModel.dayTime)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
              backgroundFilter
                .opacity(0.3)
                .ignoresSafeArea()
            }
          )
        }
        VStack {
          Spacer()
          GlobeButton(
            dayTime: viewModel.dayTime,
            onPress: {
              presentMap = true
            }
          )
        }
        
      }
      .showLoader(viewModel.isLoading)
      .showPrompt(
        show: viewModel.showErrorBinding,
        message: viewModel.errorMessage,
        style: .error
      )
      .onAppear {
        viewModel.fetchPreferredCities()
      }
      .sheet(isPresented: $presentMap, content: {
        Map(viewModel: viewModel.getMapViewModel())
      })
    } else {
      SplashView()
    }
  }
}

extension LocalizedString {
  enum Home {
    static let favoriteWeathersListTitle = "favorite_weathers_list_title".localized
    static let someWeathersListTitle = "some_weathers_list_title".localized
  }
}
