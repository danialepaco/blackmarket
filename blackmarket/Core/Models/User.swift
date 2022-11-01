//
//  User.swift
//  ios-base
//
//  Created by Rootstrap on 1/18/17.
//  Copyright © 2017 Rootstrap Inc. All rights reserved.
//

import Foundation

struct User: Codable {
  var id: Int
  var name: String
  var email: String

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case email
  }
}

struct UserData: Codable {
  var data: User

  private enum CodingKeys: String, CodingKey {
    case data
  }
}
