//
//  NSDecimalNumber+Extension.swift
//  GXCreditManagement
//
//  Created by Sky on 2018/7/12.
//

import UIKit
import Foundation



// MARK: - check
extension NSDecimalNumber {
    
    static func isNullOrEmpty(_ aNumber: NSDecimalNumber?) -> Bool {
        if aNumber == nil || aNumber == NSDecimalNumber.notANumber {
            return true
        }
        return false
    }
    
    static func getNonnullNumber(_ aNumber: NSDecimalNumber?) -> NSDecimalNumber {
        if isNullOrEmpty(aNumber) {
            return NSDecimalNumber.zero
        }
        return aNumber!
    }
    
    

}










