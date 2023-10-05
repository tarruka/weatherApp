//
//  PersistenceController.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 02/10/2023.
//

import CoreData

struct PersistenceController {
  static let shared = PersistenceController()

  let container: NSPersistentContainer

  init() {
    container = NSPersistentContainer(name: "DataBase")
    container.loadPersistentStores { description, error in
      if let error = error {
        fatalError("Error: \(error.localizedDescription)")
      }
    }
  }
  
  func save() {
    let context = container.viewContext

    if context.hasChanges {
      do {
        try context.save()
      } catch {
        // Show some error here
      }
    }
  }
}
