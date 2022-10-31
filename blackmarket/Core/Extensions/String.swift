//
//  String.swift
//  blackmarket
//
//  Created by Daniel Parra on 9/28/22.
//

import Foundation

extension String {
  var isAlphanumericWithNoSpaces: Bool {
    rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil
  }
  
  var hasPunctuationCharacters: Bool {
    rangeOfCharacter(from: CharacterSet.punctuationCharacters) != nil
  }
  
  var hasNumbers: Bool {
    rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789")) != nil
  }

  var withNoSpaces: String {
    filter { !$0.isWhitespace }
  }
  
  var localized: String {
    localize()
  }
  
  func localize(comment: String = "") -> String {
    NSLocalizedString(self, comment: comment)
  }
  
  func localized(_ args: CVarArg...) -> String {
    String(format: localized, arguments: args)
  }
  
  var validFilename: String {
    guard !isEmpty else { return "emptyFilename" }
    return addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? "emptyFilename"
  }
}
