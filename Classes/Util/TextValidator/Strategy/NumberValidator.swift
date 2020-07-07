//
//  NumberValidator.swift
//  Strategy
//
//  Created by Sky on 2020/7/7.
//  Copyright © 2020 Sky. All rights reserved.
//

import Foundation

public class NumberValidator : AbstractTextValidator {
    
    public func validate(_ str: String, out msg: inout String) -> Bool {
        print("validate number")
        if str.count == 0 {
            msg = "数字文本不能为空"
            return false
        }
        
        let pattern = "^[0-9]*$"
        guard let regularEx = try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.anchorsMatchLines) 
            else { return false }
        
        let results = regularEx.matches(in: str, options: [], range: NSRange(location: 0, length: str.count))
        if results.count == 0 {
            msg = "数字验证失败"
            return false
        } else if results.first!.range.length == 0 {
            msg = "数字验证失败 未匹配到数字"
            return false
        }
        
        return true
    }
}


