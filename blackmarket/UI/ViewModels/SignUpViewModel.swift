//
//  SignUpViewModel.swift
//  blackmarket
//
//  Created by Daniel Parra on 9/30/22.
//

import SwiftUI

class SignUpViewModel: ObservableObject, Identifiable {
    
    private let dataPrivacy = "https://www.osthus.com/osthus-glossary/data-policy/#:~:text=A%20data%20policy%20contains%20a,data%20quality%2C%20and%20data%20architecture."
    
    private let cockiesPrivacy = "https://www.grafterr.com/cookie-policy?gclid=CjwKCAjwp9qZBhBkEiwAsYFsb5_jgSsJFbQvqYDNyqLhOrgi8KZZqZjcZjUXKk9-Cj-vbV0ZgQgx6RoCIKEQAvD_BwE"
    
    @Published
    var emailConfiguration = TextFieldViewConfiguration(
        title: LocalizedString.SignUpTextField.emailTitle,
        placeholder: LocalizedString.SignUpTextField.emailPlaceholder,
        validations: [.email, .nonEmpty],
        errorMessage: LocalizedString.SignUpTextField.emailError
    )
    
    @Published
    var nameConfiguration = TextFieldViewConfiguration(
        title: LocalizedString.SignUpTextField.nameTitle,
        placeholder: LocalizedString.SignUpTextField.namePlaceholder,
        validations: [.nonEmpty],
        errorMessage: LocalizedString.SignUpTextField.nameError
    )
    
    @Published
    var passwordConfiguration = TextFieldViewConfiguration(
        title: LocalizedString.SignUpTextField.passwordTitle,
        placeholder: LocalizedString.SignUpTextField.passwordPlaceholder,
        validations: [.nonEmpty],
        isSecure: true,
        errorMessage: LocalizedString.SignUpTextField.passwordError
    )
        
    var isValid: Bool {
        return [emailConfiguration, passwordConfiguration].allSatisfy { $0.isValid }
    }
    
    lazy var disclaimerString: AttributedString = {
        do {
            var text = try AttributedString(markdown: "\(LocalizedString.SignUpView.disclaimer) [\(LocalizedString.SignUpView.dataPolicy)](\(dataPrivacy)) \(LocalizedString.SignUpView.disclaimerEnd) [\(LocalizedString.SignUpView.cookiesPolicy)](\(cockiesPrivacy))")
     
            if let range = text.range(of: LocalizedString.SignUpView.dataPolicy) {
                text[range].font = .subheadline.bold()
            }
            
            if let range = text.range(of: LocalizedString.SignUpView.cookiesPolicy) {
                text[range].font = .subheadline.bold()
            }
     
            return text
     
        } catch {
            return ""
        }
    }()
    
    lazy var alreadyHaveAnAccountString: AttributedString = {
        do {
            var text = try AttributedString(markdown: LocalizedString.SignUpView.alreadyHaveAnAccountLabel)
     
            if let range = text.range(of: LocalizedString.SignUpView.alreadyHaveAnAccountLogInLabel) {
                text[range].font = .subheadline.bold()
                text[range].foregroundColor = Color.ui.link
            }
     
            return text
     
        } catch {
            return ""
        }
    }()
        
    func logIn() {
        print("Log in button tapped")
    }    
}

private extension LocalizedString {
    enum SignUpTextField {
        static let emailTitle = "sign_in_email_textfield_title".localized
        static let emailPlaceholder = "sign_in_email_textfield_placeholder".localized
        static let emailError = "sign_in_email_textfield_error".localized
        static let nameTitle = "sign_in_name_textfield_title".localized
        static let namePlaceholder = "sign_in_name_textfield_placeholder".localized
        static let nameError = "sign_in_name_textfield_error".localized
        static let passwordTitle = "sign_in_password_textfield_title".localized
        static let passwordPlaceholder = "sign_in_password_textfield_placeholder".localized
        static let passwordError = "sign_in_password_textfield_error".localized
    }
    
    enum SignUpView {
        static let disclaimer = "sign_up_disclaimer_body".localized
        static let disclaimerEnd = "sign_up_disclaimer_end".localized
        static let dataPolicy = "sign_up_data_policy".localized
        static let cookiesPolicy = "sign_up_cookie_policy".localized
        static let alreadyHaveAnAccountLabel = "sign_up_already_have_account".localized
        static let alreadyHaveAnAccountLogInLabel = "sign_up_log_in".localized
    }
}
