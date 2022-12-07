//
//  SearchBar.swift
//  blackmarket
//
//  Created by Daniel Parra on 12/6/22.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @State private var isEditing = false
 
    var body: some View {
        ZStack(alignment: .trailing) {
            TextField(LocalizedString.SearchBarScreen.searchBarPlaceholder, text: $text)
                .frame(height: UI.SearchBar.TextField.height)
                .padding(UI.SearchBar.TextField.padding)
                .padding(.horizontal, UI.SearchBar.TextField.horizontalPadding)
                .background(.white)
                .cornerRadius(UI.Defaults.cornerRadius)
                .padding(.horizontal, UI.SearchBar.horizontalPadding)
            Image(systemName: "magnifyingglass")
                .renderingMode(.template)
                .tint(.black)
                .aspectRatio(contentMode: .fit)
                .padding(.trailing, UI.SearchBar.Image.trailingPadding)
        }
    }
}

private extension UI {
    enum SearchBar {
        
        static let horizontalPadding: CGFloat = 16.0

        enum TextField {
            static let height: CGFloat = 40.0
            static let padding: CGFloat = 8.0
            static let horizontalPadding: CGFloat = 16.0
        }
        
        enum Image {
            static let trailingPadding: CGFloat = 32.0
        }
    }
}

private extension LocalizedString {
    enum SearchBarScreen {
        static let searchBarPlaceholder = "search_bar_placeholder".localized
    }
}
