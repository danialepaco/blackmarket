//
//  blackmarketApp.swift
//  blackmarket
//
//  Created by Daniel Parra on 9/27/22.
//

import SwiftUI

@main
struct blackmarketApp: App {
    
    @State var isAuthenticated = false
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isAuthenticated {
                    TabBarView()
                } else {
                    SignInView()
                }
            }
            .onReceive(SessionManager.shared.isSessionValidPublisher, perform: { value in
                isAuthenticated = value
            })
        }
    }
}
