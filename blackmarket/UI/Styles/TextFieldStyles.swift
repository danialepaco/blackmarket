//
//  TextFieldStyles.swift
//  blackmarket
//
//  Created by Daniel Parra on 9/28/22.
//

import SwiftUI

enum TextFieldStyle {
  case primary
  case custom(
    foregroundColor: Color,
    autocapitalization: UITextAutocapitalizationType
  )
  
  var viewModifier: TextFieldViewModifier {
    switch self {
    case .primary:
      return TextFieldViewModifier(
        foregroundColor: .black,
        autocapitalization: .none
      )
    case .custom(let foregroundColor, let autocapitalization):
      return TextFieldViewModifier(
        foregroundColor: foregroundColor,
        autocapitalization: autocapitalization
      )
    }
  }
}

struct TextFieldViewModifier: ViewModifier {
  let foregroundColor: Color
  let autocapitalization: UITextAutocapitalizationType
  
  func body(content: Content) -> some View {
    content
      .foregroundColor(foregroundColor)
      .autocapitalization(autocapitalization)
  }
}

extension TextField {
  func withStyle(_ style: TextFieldStyle) -> some View {
    modifier(style.viewModifier)
  }
}

extension SecureField {
  func withStyle(_ style: TextFieldStyle) -> some View {
    modifier(style.viewModifier)
  }
}
