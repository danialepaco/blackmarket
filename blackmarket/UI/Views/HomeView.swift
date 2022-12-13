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
                Image(Image.HomeView.banner1)
                PaymentMethodsView()
                Image(Image.HomeView.banner2)
            }
            .padding(.top, UI.HomeView.VStack.topPadding)
        }
        .background(Color.homeBackground)
        .padding(.bottom, UI.HomeView.ScrollView.bottomPadding)
        .padding(.top, UI.HomeView.ScrollView.topPadding)
    }
}

private extension Image {
    enum HomeView {
        static let banner1: String = "banner1"
        static let banner2: String = "banner2"
    }
}

private extension UI {
    enum HomeView {
        
        static let topPadding: CGFloat = -50
        
        enum VStack {
            static let topPadding: CGFloat = 60
        }

        enum ScrollView {
            static let topPadding: CGFloat = -50
            static let bottomPadding: CGFloat = -10.0
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
