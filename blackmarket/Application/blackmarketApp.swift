//
//  blackmarketApp.swift
//  blackmarket
//
//  Created by Daniel Parra on 9/27/22.
//

import SwiftUI

@main
struct blackmarketApp: App {
    
    @State var isAuthenticated = SessionManager.shared.isSessionValid
    
    var body: some Scene {
        WindowGroup {
            Group {
                isAuthenticated ? AnyView(TabBarView()) : AnyView(SignInView())
            }
            .onReceive(SessionManager.shared.$isSessionValid, perform: { value in
                isAuthenticated = value
            })
        }
    }
}
