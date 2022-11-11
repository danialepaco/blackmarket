//
//  SignUpView.swift
//  blackmarket
//
//  Created by Daniel Parra on 9/30/22.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = SignUpViewModel()
    @State var errorString = ""
    
    var body: some View {
        VStack(spacing: UI.SignUpView.spacing) {
            VStack {
                Image("logo")
                    .scaledToFit()
                    .padding(.bottom, UI.SignUpView.LogoImage.bottomPadding)
                
                VStack {
                    TextFieldView(fieldConfiguration: $viewModel.emailConfiguration)
                    TextFieldView(fieldConfiguration: $viewModel.nameConfiguration)
                    TextFieldView(fieldConfiguration: $viewModel.passwordConfiguration)
                }
                .padding(.horizontal, UI.SignUpView.TextFieldsVStack.horizontalPadding)
                
                Text(errorString)
                    .font(.system(size: UI.SignUpView.ErrorLabel.fontSize, weight: .bold))
                    .foregroundColor(Color.errorRed)
                    .padding(.horizontal, UI.SignUpView.ErrorLabel.horizontalPadding)
                    .minimumScaleFactor(UI.SignUpView.ErrorLabel.minimumScaleFactor)
                    .onReceive(viewModel.errorPublisher) { value in
                        errorString = value
                    }
                
                StateButton(
                    action: {
                        Task {
                            await viewModel.signUp()
                        }
                    },
                    title: LocalizedString.SignUpScreen.signUpButtonTitle,
                    isValid: viewModel.isValid,
                    isFetching: viewModel.isFetchingPublisher
                )
                .frame(maxHeight: UI.SignUpView.StateButton.maxHeight)
                .padding(.horizontal, UI.SignUpView.StateButton.horizontalPadding)
                .padding(.bottom, UI.SignUpView.StateButton.bottomPadding)
                
                Text(viewModel.disclaimerString)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .tint(Color.link)
                    .padding(.horizontal, UI.SignUpView.DisclaimerLabel.horizontalPadding)
                    .padding(.bottom, UI.SignUpView.DisclaimerLabel.bottomPadding)
                
                Text(viewModel.alreadyHaveAnAccountString)
                    .font(.subheadline)
                    .padding(.horizontal, UI.SignUpView.AlreadyHaveAccountLabel.horizontalPadding)
                    .padding(.bottom, UI.SignUpView.AlreadyHaveAccountLabel.bottomPadding)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
            .padding(.top, UI.SignUpView.TopVStack.topPaddig)
            .frame(maxWidth: .infinity, alignment: .top)
            .background(.white)
            .cornerRadius(UI.Defaults.cornerRadius)
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .padding(
            .top, errorString.isEmpty ? UI.SignUpView.topPaddig : UI.SignUpView.topPaddigWithError
        )
        .padding(.horizontal, UI.SignUpView.horizontalPaddig)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("background")
                .scaledToFill()
        )
    }
}

private extension UI {
    enum SignUpView {
        static let spacing: CGFloat = 16.0
        static let topPaddig: CGFloat = 60.0
        static let topPaddigWithError: CGFloat = 30.0
        static let horizontalPaddig: CGFloat = 25.0
        
        enum TopVStack {
            static let topPaddig: CGFloat = 40.0
            static let horizontalPaddig: CGFloat = 25.0
        }
        
        enum LogoImage {
            static let bottomPadding: CGFloat = 36.0
        }
        
        enum TextFieldsVStack {
            static let horizontalPadding: CGFloat = 28.0
        }
        
        enum ErrorLabel {
            static let horizontalPadding: CGFloat = 22.0
            static let minimumScaleFactor: CGFloat = 0.5
            static let fontSize: CGFloat = 16.0
        }
        
        enum StateButton {
            static let maxHeight: CGFloat = 45.0
            static let horizontalPadding: CGFloat = 28.0
            static let bottomPadding: CGFloat = 16.0
        }
        
        enum DisclaimerLabel {
            static let horizontalPadding: CGFloat = 28.0
            static let bottomPadding: CGFloat = 16.0
        }
        
        enum AlreadyHaveAccountLabel {
            static let horizontalPadding: CGFloat = 28.0
            static let bottomPadding: CGFloat = 16.0
        }
    }
}

private extension LocalizedString {
    enum SignUpScreen {
        static let signUpButtonTitle = "sign_in_screen_sign_up_button".localized
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
