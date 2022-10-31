//
//  TextFieldViewConfiguration.swift
//  swiftui-base
//
//  Created by Leandro Higa on 31/08/2022.
//

import Combine

final class TextFieldViewConfiguration: ObservableObject {
        
    @Published var value: String = ""

    var shouldShowError: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isValid, isEmpty)
            .map { isValid, isEmpty in
                !isValid && !isEmpty
            }.eraseToAnyPublisher()
    }
    
    var isValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($value, Just(validations))
            .map { value, validations in
                validations.allSatisfy { validation in
                    value.validates([validation])
                }
            }.eraseToAnyPublisher()
    }
        
    private (set) var validations: [ValidationType]
    var errorMessage: String
    var title: String
    var placeholder: String
    var isSecure = false
    
    var isEmpty: AnyPublisher<Bool, Never> {
        $value.map {
            $0.isEmpty
        }.eraseToAnyPublisher()
    }
    
    init(
        title: String,
        placeholder: String,
        value: String = "",
        validations: [ValidationType] = [.none],
        isSecure: Bool = false,
        errorMessage: String = ""
    ) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
        self.validations = validations
        self.errorMessage = errorMessage
        self.isSecure = isSecure
    }
}
