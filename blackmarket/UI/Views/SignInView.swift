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
            VStack(spacing: 16.0) {
                VStack {
                    Image("logo")
                        .scaledToFit()
                        .padding(.bottom, 36.0)
                    
                    VStack {
                        TextFieldView(fieldConfiguration: $viewModel.emailConfiguration)
                        TextFieldView(fieldConfiguration: $viewModel.passwordConfiguration)
                    }
                    .padding(.horizontal, 28.0)
                    
                    StateButton(
                        action: { viewModel.logIn() },
                        title: LocalizedString.SignInScreen.signInButton,
                        isEnabled: viewModel.isValid
                    )
                    .frame(maxHeight: 45)
                    .padding(.horizontal, 28.0)
                    .padding(.bottom, 16.0)
                    
                    NavigationLink {
                        ForgotPasswordView()
                    } label: {
                        Text(LocalizedString.SignInScreen.forgotPasswordButton)
                            .fontWeight(.bold)
                            .foregroundColor(Color.link)
                            .padding(.bottom, 20.0)
                    }
                }
                .padding(.top, 40.0)
                .frame(maxWidth: .infinity, alignment: .top)
                .background(.white)
                .cornerRadius(8)
                
                VStack {
                    Text(LocalizedString.SignInScreen.noAccountLabel)
                        .padding(.top, 20.0)
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text(LocalizedString.SignInScreen.signUpButtonTitle)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, maxHeight: 45)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.black)
                            )
                    }
                    .padding(.horizontal, 28.0)
                    .padding(.bottom, 16.0)
                }
                .frame(maxWidth: .infinity, alignment: .bottom)
                .background(.white)
                .cornerRadius(8)
                Spacer()
            }
            .padding(.top, 60)
            .padding(.horizontal, 25)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("background")
                    .scaledToFill()
            )
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
