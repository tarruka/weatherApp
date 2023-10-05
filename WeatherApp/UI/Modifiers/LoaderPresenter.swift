//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 01/10/2023.
//

import SwiftUI

struct LoaderPresenterModifier: ViewModifier {
  
  var isLoading: Bool
  var completion: (() -> Void)?

  func body(content: Content) -> some View {
    ZStack {
      content
      if isLoading {
        LoaderView()
          .ignoresSafeArea()
      }
    }.onChange(of: isLoading) { isLoading in
      ///Returns a completion when the loader stops
      if !isLoading {
        completion?()
      }
    }
  }
}

extension View {
  func showLoader(_ isLoading: Bool, completion: (() -> Void)? = nil) -> some View {
    modifier(LoaderPresenterModifier(isLoading: isLoading, completion: completion))
  }
}

