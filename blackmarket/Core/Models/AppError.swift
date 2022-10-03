//
//  AppError.swift
//  blackmarket
//
//  Created by Daniel Parra on 10/3/22.
//

import Foundation

struct AppError {
  static let domain = Bundle.main.bundleIdentifier ?? ""
  
  static func error(
    domain: ErrorDomain = .generic, code: Int? = nil,
    localizedDescription: String = ""
  ) -> NSError {
    NSError(
        domain: AppError.domain + "." + domain.rawValue,
        code: code ?? 0,
        userInfo: [NSLocalizedDescriptionKey: localizedDescription]
    )
  }
}

enum ErrorDomain: String {
  case generic = "GenericError"
  case parsing = "ParsingError"
  case network = "NetworkError"
}
