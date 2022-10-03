//
//  JSONEncoding.swift
//  blackmarket
//
//  Created by Daniel Parra on 10/3/22.
//

import Foundation

extension JSONDecoder {
  
  func decode<T>(
    _ type: T.Type, from dictionary: [String: Any]
  ) throws -> T where T: Decodable {
    let data = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
    return try decode(T.self, from: data ?? Data())
  }
}
