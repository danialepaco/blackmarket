//
//  Validatable+String.swift
//  blackmarket
//
//  Created by Daniel Parra on 9/28/22.
//

import Foundation

enum ValidationType {
    case email
    case nonEmpty
    case integer
    case date(dateFormat: String)
    case phone
}

internal protocol Validatable {
    func validates(_ validations: [ValidationType]) -> Bool
}

extension String: Validatable {
    func validates(_ validations: [ValidationType]) -> Bool {
        validations.allSatisfy { validation in
            switch validation {
            case .email:
                return isEmailFormatted()
            case .integer:
                return isInteger()
            case .date(dateFormat: let dateFormat):
                return isDateFormatted(dateFormat)
            case .phone:
                return isPhoneNumber()
            case .nonEmpty:
                return !isEmpty
            }
        }
    }
    
    func isEmailFormatted() -> Bool {
        let predicate = NSPredicate(
            format: "SELF MATCHES %@",
            "[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*@([A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?"
        )
        return predicate.evaluate(with: self)
    }
    
    func isInteger() -> Bool {
        Int(self) != nil
    }
    
    func isDateFormatted(_ dateFormat: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self) != nil
    }
    
    func isPhoneNumber() -> Bool {
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", "^\\d{3}-\\d{3}-\\d{4}$")
        return phonePredicate.evaluate(with: self)
    }
}
