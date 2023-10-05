//
//  WeatherApp.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 29/09/2023.
//

import SwiftUI

@main
struct WeatherApp: App {

  let persistenceController = PersistenceController.shared

  var body: some Scene {
    WindowGroup {
      HomeView(viewModel: HomeViewModel())
        .environment(
          \.managedObjectContext,
           persistenceController.container.viewContext
        )
    }
  }
}
