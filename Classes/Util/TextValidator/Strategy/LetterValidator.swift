//
//  LetterValidator.swift
//  Strategy
//
//  Created by Sky on 2020/7/7.
//  Copyright © 2020 Sky. All rights reserved.
//

import Foundation

public class LetterValidator : AbstractTextValidator {
    
    public func validate(_ str: String, out msg: inout String) -> Bool {
        print("validate Letter")
        
        if str.count == 0 {
            msg = "字母文本不能为空"
            return false
        }
        
        let pattern = "^[a-zA-Z]*$"
        guard let regularEx = try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.anchorsMatchLines) 
            else { return false }
        
        //        let num = regularEx.numberOfMatches(in: str, options: NSRegularExpression.MatchingOptions.anchored, range: NSRange(location: 0, length: str.count))
        
        let results = regularEx.matches(in: str, options: [], range: NSRange(location: 0, length: str.count))
        if results.count == 0 {
            msg = "字母验证失败"
            return false
        } else if results.first!.range.length == 0 {
            msg = "字母验证失败 未匹配到字母"
            return false
        }
        
        return true
    }
    
}
