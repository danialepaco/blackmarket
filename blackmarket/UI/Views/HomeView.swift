//
//  HomeView.swift
//  blackmarket
//
//  Created by Daniel Parra on 10/19/22.
//

import SwiftUI

struct HomeView: View {
    
    @State var searchText: String = ""

    var body: some View {
        ScrollView {
            VStack {
                SearchBar(text: $searchText)
                Image("banner1")
                PaymentMethodsView()
                Image("banner2")
            }
        }
        .padding(.top, UI.HomeView.ScrollView.topPadding)
        .background(Color.homeBackground)
        .padding(.bottom, UI.HomeView.ScrollView.bottomPadding)
        .padding(.top, UI.HomeView.topPadding)
    }
}

private extension UI {
    enum HomeView {
        
        static let topPadding: CGFloat = -50

        enum ScrollView {
            static let topPadding: CGFloat = 60
            static let bottomPadding: CGFloat = -10.0
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
