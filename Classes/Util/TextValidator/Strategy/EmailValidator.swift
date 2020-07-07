//
//  EmailValidator.swift
//  Strategy
//
//  Created by Sky on 2020/7/7.
//  Copyright © 2020 Sky. All rights reserved.
//

import Foundation
import UIKit

public class EmailValidator : AbstractTextValidator {
    
    public func validate(_ str: String, out msg: inout String) -> Bool {
        print("validate email ")
        if str.count == 0 {
            msg = "Email文本不能为空"
            return false
        }
        
        let pattern = "[a-zA-Z0-9_]+@[0-9a-z]+(\\.[a-z]+)+"
        guard let regularEx = try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.anchorsMatchLines) 
            else { return false }
        
        let results = regularEx.matches(in: str, options: [], range: NSRange(location: 0, length: str.count))
        if results.count == 0 {
            msg = "Email验证失败"
            return false
        } else if results.first!.range.length == 0 {
            msg = "Email验证失败 未匹配到字符"
            return false
        }
        
        return true
    }
    
    
}



