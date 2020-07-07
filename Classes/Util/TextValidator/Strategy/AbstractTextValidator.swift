//
//  AbstractTextValidator.swift
//  Strategy
//
//  Created by Sky on 2020/7/7.
//  Copyright © 2020 Sky. All rights reserved.
//

import Foundation
import UIKit


public protocol AbstractTextValidator {
    /// 验证文本的方法
    func validate(_ str: String, out msg: inout String) -> Bool
}

public extension AbstractTextValidator {
    func validate(_ str: String, out msg: inout String) -> Bool {
        print("AbstractTextValidator str =", str)
        msg = "AbstractTextValidator"
        return false
    }
}





