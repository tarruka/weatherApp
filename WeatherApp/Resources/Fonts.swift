//
//  Fonts.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 01/10/2023.
//

import Foundation
import SwiftUI

// MARK: Custom fonts

enum CustomFont: String {
  case onestBlack = "Onest-Black"
  case onestBold = "Onest-Bold"
  case onestExtraBold = "Onest-ExtraBold"
  case onestRegular = "Onest-Regular"
  case onestThin = "Onest-Thin"
  case onestLight = "Onest-Light"
  case onestExtraLight = "Onest-ExtraLight"
  case onestMedium = "Onest-Medium"
  case onestSemiBold = "Onest-SemiBold"
  
  func size(_ size: CGFloat) -> Font {
    Font.custom(self.rawValue, size: size)
  }
}

extension Font {
  static let h0Black = CustomFont.onestBlack.size(60)
  static let h1Black = CustomFont.onestBlack.size(22)
  static let h2Black = CustomFont.onestBlack.size(20)
  static let h3Black = CustomFont.onestBlack.size(18)
  static let h4Black = CustomFont.onestBlack.size(16)
  static let h5Black = CustomFont.onestBlack.size(14)
  static let h6Black = CustomFont.onestBlack.size(12)
  
  static let h1Bold = CustomFont.onestBold.size(22)
  static let h2Bold = CustomFont.onestBold.size(20)
  static let h3Bold = CustomFont.onestBold.size(18)
  static let h4Bold = CustomFont.onestBold.size(16)
  static let h5Bold = CustomFont.onestBold.size(14)
  static let h6Bold = CustomFont.onestBold.size(12)
  
  static let h1Medium = CustomFont.onestMedium.size(22)
  static let h2Medium = CustomFont.onestMedium.size(20)
  static let h3Medium = CustomFont.onestMedium.size(18)
  static let h4Medium = CustomFont.onestMedium.size(16)
  static let h5Medium = CustomFont.onestMedium.size(14)
  static let h6Medium = CustomFont.onestMedium.size(12)
  
  static let h1Regular = CustomFont.onestRegular.size(22)
  static let h2Regular = CustomFont.onestRegular.size(20)
  static let h3Regular = CustomFont.onestRegular.size(18)
  static let h4Regular = CustomFont.onestRegular.size(16)
  static let h5Regular = CustomFont.onestRegular.size(14)
  static let h6Regular = CustomFont.onestRegular.size(12)
}
