//
//  ViewRouter.swift
//  blackmarket
//
//  Created by Daniel Parra on 12/6/22.
//

import SwiftUI

class ViewRouter: ObservableObject {
    @Published var currentPage: TabPage = .home
}

enum TabPage {
    case home
    case discounts
    case cart
    case liked
    case more
}