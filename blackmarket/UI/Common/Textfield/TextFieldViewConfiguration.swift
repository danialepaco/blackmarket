//
//  TextFieldViewConfiguration.swift
//  swiftui-base
//
//  Created by Leandro Higa on 31/08/2022.
//

import Combine

final class TextFieldViewConfiguration: ObservableObject {
        
    @Published var value: String = ""
    
    var validations: [ValidationType]
    var errorMessage: String
    var title: String
    var placeholder: String
    var isSecure = false
    
    private(set) var isValid = true
    private var subscribers = Set<AnyCancellable>()
    
    var isEmpty: Bool {
        return value.isEmpty
    }
    
    var shouldShowError: Bool {
        !isEmpty && !isValid
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
                
        $value.sink { value in
            self.validate()
        }
        .store(in: &subscribers)
    }
    
    func validate() {
        isValid = value.validates(validations)
    }
}
