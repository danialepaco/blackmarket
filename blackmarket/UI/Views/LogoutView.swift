//
//  LogoutView.swift
//  blackmarket
//
//  Created by Daniel Parra on 12/6/22.
//

import SwiftUI

struct LogoutView: View {
    
    @ObservedObject var viewModel = LogoutViewModel()
    
    var body: some View {
        StateButton(
            action: {
                Task {
                    await viewModel.logOut()
                }
            },
            title: LocalizedString.LogoutScreen.logoutButtonTitle,
            isFetching: viewModel.isFetchingPublisher
        )
        .frame(maxHeight: UI.LogoutView.StateButton.maxHeight)
        .padding(.horizontal, UI.LogoutView.StateButton.horizontalPadding)
        .padding(.bottom, UI.LogoutView.StateButton.bottomPadding)
    }
}

private extension UI {
    enum LogoutView {
        
        enum StateButton {
            static let maxHeight: CGFloat = 45.0
            static let horizontalPadding: CGFloat = 28.0
            static let bottomPadding: CGFloat = 16.0
        }
    }
}

private extension LocalizedString {
    enum LogoutScreen {
        static let logoutButtonTitle = "logout_button_title".localized
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
