//
//  TabBarView.swift
//  blackmarket
//
//  Created by Daniel Parra on 10/2/22.
//

import SwiftUI

struct TabBarView: View {
    
    @StateObject var viewRouter: ViewRouter
        
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                switch viewRouter.currentPage {
                case .home:
                    HomeView()
                case .discounts:
                    Text("discounts")
                case .cart:
                   Text("cart")
                case .liked:
                    Text("liked")
                case .more:
                    LogoutView()
                }
                Spacer()
                ZStack {
                    HStack {
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .home, width: geometry.size.width/5, height: geometry.size.height/28, imageName: Image.TabBarView.homeIcon)
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .discounts, width: geometry.size.width/5, height: geometry.size.height/28, imageName: Image.TabBarView.discountIcon)
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .cart, width: geometry.size.width/5, height: geometry.size.height/28, imageName: Image.TabBarView.cartIcon)
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .liked, width: geometry.size.width/5, height: geometry.size.height/28, imageName: Image.TabBarView.heartIcon)
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .more, width: geometry.size.width/5, height: geometry.size.height/28, imageName: Image.TabBarView.moreIcon)
                    }
                        .frame(width: geometry.size.width, height: geometry.size.height/10)
                        .background(Color.black.shadow(radius: 2))
                }
            }
                .edgesIgnoringSafeArea(.bottom)
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
        TabBarView(viewRouter: ViewRouter())
            .preferredColorScheme(.light)
    }
}
