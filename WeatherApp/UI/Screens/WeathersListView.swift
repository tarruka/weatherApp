//
//  WeathersListView.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 03/10/2023.
//

import SwiftUI

struct WeathersListView: View {
  
  private let title: String
  private let foregroundColor: Color
  private var weathers: [Weather] = []
  private let removableItems: Bool
  @Binding private var selectedWeatherId: Int?
  
  init(weathers: [Weather], title: String, foregroundColor: Color, removableItems: Bool, selectedWeatherId: Binding<Int?>) {
    self._selectedWeatherId = selectedWeatherId
    self.weathers = weathers
    self.title = title
    self.foregroundColor = foregroundColor
    self.removableItems = removableItems
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      Text(title)
        .font(.h4Bold)
        .padding(.horizontal)
        .foregroundColor(foregroundColor)
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: UI.Padding.small) {
          ForEach(weathers) { weather in
            Button(action: {
              selectedWeatherId = weather.id
            }, label: {
              CityWeatherCardView(
                viewModel: CityWeatherViewModel(weather: weather),
                removable: removableItems
              )
              NavigationLink(
                "",
                destination: WeatherDetailView(viewModel: CityWeatherViewModel(weather: weather)),
                tag: weather.id,
                selection: $selectedWeatherId
              )
            }).contentShape(Rectangle())
          }
        }.padding(.leading)
        
      }
    }.frame(height: UI.WeathersList.favoritesCitiesListHeight)
  }
}

private extension UI {
  enum WeathersList {
    static let favoritesCitiesListHeight: CGFloat = 230
  }
}
