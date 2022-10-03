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
    
    var body: some View {
        VStack(spacing: 16.0) {
            VStack {
                Image("logo")
                    .scaledToFit()
                    .padding(.bottom, 36.0)
                
                VStack {
                    TextFieldView(fieldConfiguration: $viewModel.emailConfiguration)
                    TextFieldView(fieldConfiguration: $viewModel.nameConfiguration)
                    TextFieldView(fieldConfiguration: $viewModel.passwordConfiguration)
                }
                .padding(.horizontal, 28.0)

                StateButton(action: {
                    viewModel.logIn()
                }, title: LocalizedString.SignUpScreen.signUpButtonTitle, isEnabled: viewModel.isValid)
                .frame(maxHeight: 45)
                .padding(.horizontal, 28.0)
                .padding(.bottom, 16.0)
                
                Text(viewModel.disclaimerString)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .tint(Color.ui.link)
                    .padding(.horizontal, 28.0)
                    .padding(.bottom, 16.0)
                
                Text(viewModel.alreadyHaveAnAccountString)
                    .font(.subheadline)
                    .padding(.horizontal, 28.0)
                    .padding(.bottom, 16.0)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
            .padding(.top, 40.0)
            .frame(maxWidth: .infinity, alignment: .top)
            .background(.white)
            .cornerRadius(8)
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .padding(.top, 60)
        .padding(.horizontal, 25)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("background")
                .scaledToFill()
        )
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
