//
//  AnimatedMonoLogo.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 02/10/2023.
//

import SwiftUI

enum DotState {
  case show
  case dismiss
}

struct AnimatedMonoLogo: View {
  
  @State private var dotState: DotState = .dismiss
  @State private var startAnimation: Bool = false
  
  var opacity: CGFloat {
    dotState == .show ? 1 : 0
  }
  
  var body: some View {
    ZStack {
      Image.monoLogoMain
      Image.monoLogoFirstDot
        .opacity(opacity)
        .animation(.linear.delay(dotState == .dismiss ? UI.MonoLogo.maxDelay : UI.MonoLogo.minDelay))
      Image.monoLogoSecondDot
        .opacity(opacity)
        .animation(.linear.delay(UI.MonoLogo.midDelay))
      Image.monoLogoThirdDot
        .opacity(opacity)
        .animation(.linear.delay(dotState == .dismiss ? UI.MonoLogo.minDelay : UI.MonoLogo.maxDelay))
    }
    .onAppear {
      start()
    }
  }
  
  private func start() {
    dotState = .show
    DispatchQueue.main.asyncAfter(deadline: .now() + UI.MonoLogo.maxDelay) {
      backwards()
    }
  }
  private func backwards() {
    dotState = .dismiss
    DispatchQueue.main.asyncAfter(deadline: .now() + UI.MonoLogo.maxDelay) {
      start()
    }
  }
}

private extension UI {
  enum MonoLogo {
    static let maxDelay: Double = 0.6
    static let midDelay: Double = 0.3
    static let minDelay: Double = 0
  }
}
