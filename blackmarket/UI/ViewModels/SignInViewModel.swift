//
//  SignInViewModel.swift
//  blackmarket
//
//  Created by Daniel Parra on 9/28/22.
//

import Foundation

class SignInViewModel: ObservableObject, Identifiable {
    
    @Published var emailConfiguration = TextFieldViewConfiguration(
        title: LocalizedString.SignInTextField.emailTitle,
        placeholder: LocalizedString.SignInTextField.emailPlaceholder,
        validations: [.email, .nonEmpty],
        errorMessage: LocalizedString.SignInTextField.emailError
    )
    
    @Published var passwordConfiguration = TextFieldViewConfiguration(
        title: LocalizedString.SignInTextField.passwordTitle,
        placeholder: LocalizedString.SignInTextField.passwordPlaceholder,
        validations: [.nonEmpty],
        isSecure: true,
        errorMessage: LocalizedString.SignInTextField.passwordError
    )
        
    var isValid: Bool {
        return [emailConfiguration, passwordConfiguration].allSatisfy { $0.isValid }
    }
        
    func logIn() {
        print("Log in button tapped")
    }
}

private extension LocalizedString {
    enum SignInTextField {
        static let emailTitle = "sign_in_email_textfield_title".localized
        static let emailPlaceholder = "sign_in_email_textfield_placeholder".localized
        static let emailError = "sign_in_email_textfield_error".localized
        static let passwordTitle = "sign_in_password_textfield_title".localized
        static let passwordPlaceholder = "sign_in_password_textfield_placeholder".localized
        static let passwordError = "sign_in_password_textfield_error".localized
    }
}
