//
//  TabBarView.swift
//  blackmarket
//
//  Created by Daniel Parra on 10/2/22.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(Image.TabBarView.homeIcon)
                }
            Text("Discounts")
                .tabItem {
                    Image(Image.TabBarView.discountIcon)
                }
            Text("Cart")
                .tabItem {
                    Image(Image.TabBarView.cartIcon)
                }
            Text("Liked")
                .tabItem {
                    Image(Image.TabBarView.heartIcon)
                }
            LogoutView()
                .tabItem {
                    Image(Image.TabBarView.moreIcon)
                }
        }
        .tint(.white)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = .black
            appearance.stackedLayoutAppearance.selected.iconColor = .white
            appearance.stackedLayoutAppearance.normal.iconColor = .gray
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

private extension Image {
    enum TabBarView {
        static let homeIcon: String = "homeIcon"
        static let discountIcon: String = "discountIcon"
        static let cartIcon: String = "cartIcon"
        static let heartIcon: String = "heartIcon"
        static let moreIcon: String = "moreIcon"
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
