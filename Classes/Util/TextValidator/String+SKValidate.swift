//
//  String+SKValidate.swift
//  Strategy
//
//  Created by Sky on 2020/7/7.
//  Copyright © 2020 Sky. All rights reserved.
//

import Foundation

public enum ValidateType {
    case Number
    case Letter
    case Email
}

    
public extension String {
    
    @discardableResult
    func validate(type: ValidateType) -> Bool {
        switch type {
        case .Number:
            return validateNumber()
        case .Letter:
            return validateLetter()
        case .Email:
            return validateEmail()
            
            
            
        }
    }
    
    
}

public extension String {
    
    @discardableResult
    func validateNumber() -> Bool {
        var msg = ""
        return NumberValidator().validate(self, out: &msg)
    }
    
    @discardableResult
    func validateLetter() -> Bool {
        var msg = ""
        return LetterValidator().validate(self, out: &msg)
    }
    
    @discardableResult
    func validateEmail() -> Bool {
        var msg = ""
        return EmailValidator().validate(self, out: &msg)
    }
    
    
    
    
}

