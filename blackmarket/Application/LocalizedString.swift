//
//  LocalizedString.swift
//  blackmarket
//
//  Created by Daniel Parra on 9/28/22.
//

import Foundation

enum LocalizedString {
    /// A function to create a String with format and multiple parameters
    /// - Parameters:
    ///   - format: The base string with format that needs to be replaced with params. Ex: "Welcome %@"
    ///   - params: Parameters that needs to be replaced in base string. Ex: "username".
    /// - Returns: A custom String with params included. Ex: "Welcome username"
    static func parametrizedString(format: String, params: String...) -> String {
      String(format: format, arguments: params)
    }
}
