//
//  PromptViewModifier.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 01/10/2023.
//

import Foundation
import SwiftUI


enum PromptPoint {
  case hidden
  case presented
  case variable(value: CGSize)
  
  var offset: CGSize {
    switch self {
    case .variable(let value):
      return value
    case .presented:
      return .zero
    case .hidden:
      return UI.PromptViewModifier.initialPromptOffset
    }
  }
}

struct PromptViewModifier: ViewModifier {
  
  @State private var offsetPoint: PromptPoint = .hidden
  @Binding private var show: Bool
  private var title: String?
  private let message: String
  private let style: PromptStyle
  
  init(show: Binding<Bool>, title: String?, message: String, style: PromptStyle) {
    self._show = show
    self.title = title
    self.message = message
    self.style = style
  }
  
  func body(content: Content) -> some View {
    ZStack {
      content
      VStack {
        if show {
          PromptView(title: title, message: message, style: style)
            .frame(maxWidth: .infinity)
            .offset(offsetPoint.offset)
            .transition(.move(edge: .top).combined(with: .opacity))
            .onTapGesture {
              hidePrompt()
            }
            .gesture(
              DragGesture()
                .onChanged({ value in
                  if value.translation.height < .zero {
                    offsetPoint = .variable(
                      value: CGSize(
                        width: .zero,
                        height: value.translation.height
                      )
                    )
                  }
                })
                .onEnded({ value in
                  if value.translation.height < .zero {
                    hidePrompt()
                  }
                })
            )
       }
        Spacer()
      }
      .onChange(of: show, perform: { newValue in
        offsetPoint = show ? .presented : .hidden
      })
      .animation(UI.PromptViewModifier.animation, value: show)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
  
  private func hidePrompt() {
    withAnimation {
      offsetPoint = .hidden
      show = false
    }
  }
}

extension View {
  func showPrompt(show: Binding<Bool>, title: String? = nil, message: String, style: PromptStyle) -> some View {
    modifier(PromptViewModifier(show: show, title: title, message: message, style: style))
  }
}

private extension UI {
  enum PromptViewModifier {
    static let initialPromptOffset = CGSize(width: .zero, height: -100)
    static let animation: Animation = .spring(response: 0.4, dampingFraction: 0.6)
  }
}

