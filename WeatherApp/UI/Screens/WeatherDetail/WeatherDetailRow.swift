//
//  WeatherDetailRow.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 04/10/2023.
//

import SwiftUI

struct WeatherDetailRow: View {
  let key: String
  let value: String
  
  var body: some View {
    HStack {
      Text(key)
        .font(.h2Bold)
      Spacer()
      Text(value)
        .font(.h2Medium)
    }
  }
}
