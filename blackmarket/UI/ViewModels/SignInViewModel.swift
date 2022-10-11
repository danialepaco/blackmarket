//
//  SignInViewModel.swift
//  blackmarket
//
//  Created by Daniel Parra on 9/28/22.
//

import Combine

class SignInViewModel: ObservableObject, Identifiable {
    
    private let authServices: AuthenticationServices
    
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
    
    var isValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(emailConfiguration.isValid, passwordConfiguration.isValid)
            .map { emailIsValid, passwordIsValid in
                emailIsValid && passwordIsValid
            }.eraseToAnyPublisher()
    }
    
    init(
        authServices: AuthenticationServices = AuthenticationServices()
    ) {
        self.authServices = authServices
    }
    
    func logIn() {
        authServices.login(
            email: emailConfiguration.value,
            password: passwordConfiguration.value
        ) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                break
            }
        }
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
