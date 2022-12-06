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
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isAuthenticated {
                    TabBarView(viewRouter: viewRouter)
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
