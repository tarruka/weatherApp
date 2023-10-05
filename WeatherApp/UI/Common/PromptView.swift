//
//  PromptView.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 01/10/2023.
//

import SwiftUI

enum PromptStyle: Equatable {
  case error
  case warning
  case success
  case custom(image: Image, color: Color)
  
  var icon: Image {
    switch self {
    case .error:
      return Image.promptError
    case .warning:
      return Image.promptWarning
    case .success:
      return Image.promptSuccess
    case .custom(let image, _):
      return image
    }
  }
  
  var color: Color {
    switch self {
    case .error:
      return .promptError
    case .warning:
      return .promptWarning
    case .success:
      return .promptSuccess
    case .custom(_, let color):
      return color
    }
  }
}

struct PromptView: View {
  
  var title: String?
  let message: String
  let style: PromptStyle
  
  var body: some View {
    VStack(alignment: .leading, spacing: UI.Padding.small) {
      if let title = title {
        HStack {
          style.icon
            .foregroundColor(style.color)
          Text(title)
            .fontWeight(.semibold)
        }
        Text(message)
          .font(.h5Medium)
          .fixedSize(horizontal: false, vertical: true)
      } else {
        HStack(alignment: .top) {
          style.icon
            .foregroundColor(style.color)
          Text(message)
            .font(.body)
            .minimumScaleFactor(UI.PromptView.messageScaleFactor)
        }
      }
    }
    .padding(UI.Padding.small)
    .background(
      RoundedRectangle(
        cornerRadius: UI.CornerRadius.medium,
        style: .continuous
      )
      .foregroundColor(.white)
      .shadow(radius: UI.CornerRadius.medium)
      
    )
    .shadow(radius: UI.CornerRadius.medium)
    .frame(maxWidth: .infinity, maxHeight: UI.PromptView.height)
    .padding(.horizontal)
  }
}

struct PromptView_Previews: PreviewProvider {
    static var previews: some View {
      PromptView(
        title: "This is a large title",
        message: "Hello, this is a test message to see how it looks in the prompt",
        style: .success
      )
    }
}

extension UI {
  enum PromptView {
    static let height: CGFloat = 60
    static let messageScaleFactor: CGFloat = 0.8
  }
}
