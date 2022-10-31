//
//  ContentView.swift
//  blackmarket
//
//  Created by Daniel Parra on 9/27/22.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel = SignInViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: UI.SignInView.spacing) {
                VStack {
                    Image("logo")
                        .scaledToFit()
                        .padding(.bottom, UI.SignInView.LogoImage.padding)
                    
                    VStack {
                        TextFieldView(fieldConfiguration: $viewModel.emailConfiguration)
                        TextFieldView(fieldConfiguration: $viewModel.passwordConfiguration)
                    }
                    .padding(.horizontal, UI.SignInView.TextFieldsVStack.padding)
                    
                    StateButton(
                        action: { viewModel.logIn() },
                        title: LocalizedString.SignInScreen.signInButton,
                        isValid: viewModel.isValid
                    )
                    .frame(maxHeight: UI.SignInView.StateButton.maxHeight)
                    .padding(.horizontal, UI.SignInView.StateButton.horizontalPadding)
                    .padding(.bottom, UI.SignInView.StateButton.bottomPadding)
                    
                    NavigationLink {
                        ForgotPasswordView()
                    } label: {
                        Text(LocalizedString.SignInScreen.forgotPasswordButton)
                            .fontWeight(.bold)
                            .foregroundColor(Color.link)
                            .padding(.bottom, UI.SignInView.ForgotPasswordLabel.bottomPadding)
                    }
                }
                .padding(.top, UI.SignInView.TopVStack.topPaddig)
                .frame(maxWidth: .infinity, alignment: .top)
                .background(.white)
                .cornerRadius(UI.Defaults.cornerRadius)
                
                VStack {
                    Text(LocalizedString.SignInScreen.noAccountLabel)
                        .padding(.top, UI.SignInView.NoAccountLabel.topPadding)
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text(LocalizedString.SignInScreen.signUpButtonTitle)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, maxHeight: UI.SignInView.SignUpButton.maxHeight)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: UI.Defaults.cornerRadius)
                                    .stroke(.black)
                            )
                    }
                    .padding(.horizontal, UI.SignInView.SignUpLink.horizontalPadding)
                    .padding(.bottom, UI.SignInView.SignUpLink.bottomPadding)
                }
                .frame(maxWidth: .infinity, alignment: .bottom)
                .background(.white)
                .cornerRadius(UI.Defaults.cornerRadius)
                Spacer()
            }
            .padding(.top, UI.SignInView.BotomVStack.topPaddig)
            .padding(.horizontal, UI.SignInView.BotomVStack.horizontalPaddig)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("background")
                    .scaledToFill()
            )
        }
    }
}

private extension UI {
    enum SignInView {
        static let spacing: CGFloat = 16.0
        
        enum TopVStack {
            static let topPaddig: CGFloat = 40.0
        }
        
        enum BotomVStack {
            static let topPaddig: CGFloat = 60.0
            static let horizontalPaddig: CGFloat = 25.0
        }
        
        enum LogoImage {
            static let padding: CGFloat = 36.0
        }
        
        enum TextFieldsVStack {
            static let padding: CGFloat = 28.0
        }
        
        enum StateButton {
            static let maxHeight: CGFloat = 45.0
            static let horizontalPadding: CGFloat = 28.0
            static let bottomPadding: CGFloat = 16.0
        }
        
        enum ForgotPasswordLabel {
            static let bottomPadding: CGFloat = 20.0
        }
        
        enum NoAccountLabel {
            static let topPadding: CGFloat = 20.0
        }
        
        enum SignUpButton {
            static let maxHeight: CGFloat = 45.0
            static let horizontalPadding: CGFloat = 28.0
            static let bottomPadding: CGFloat = 16.0
        }
        
        enum SignUpLink {
            static let horizontalPadding: CGFloat = 28.0
            static let bottomPadding: CGFloat = 16.0
        }
    }
}

private extension LocalizedString {
    enum SignInScreen {
        static let signInButton = "sign_in_screen_log_in_button".localized
        static let signUpButtonTitle = "sign_in_screen_sign_up_button".localized
        static let forgotPasswordButton = "sign_in_screen_forgot_button".localized
        static let noAccountLabel = "sign_in_screen_no_account_label".localized
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
