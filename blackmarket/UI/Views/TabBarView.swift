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
                    Text("Liked")
                case .cart:
                   Text("Records")
                case .liked:
                    Text("User")
                case .more:
                    LogoutView()
                }
                Spacer()
                ZStack {
                    HStack {
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .home, width: geometry.size.width/5, height: geometry.size.height/28, imageName: "homeIcon")
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .discounts, width: geometry.size.width/5, height: geometry.size.height/28, imageName: "discountIcon")
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .cart, width: geometry.size.width/5, height: geometry.size.height/28, imageName: "cartIcon")
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .liked, width: geometry.size.width/5, height: geometry.size.height/28, imageName: "heartIcon")
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .more, width: geometry.size.width/5, height: geometry.size.height/28, imageName: "moreIcon")
                    }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color.black.shadow(radius: 2))
                }
            }
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(viewRouter: ViewRouter())
            .preferredColorScheme(.light)
    }
}
