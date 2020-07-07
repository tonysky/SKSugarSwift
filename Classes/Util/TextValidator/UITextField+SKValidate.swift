//
//  UITextField+SKValidate.swift
//  Strategy
//
//  Created by Sky on 2020/7/7.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit

public extension UITextField  {
    
    private struct RuntimeKey {
        static var validatorKey =  "validatorKey"
    }
    private var runtimeContainer: RuntimeContainer? {
        get {
            objc_getAssociatedObject(self, &RuntimeKey.validatorKey) as? RuntimeContainer
        }
        set {
            if runtimeContainer != nil { return }
            objc_setAssociatedObject(self, &RuntimeKey.validatorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    class RuntimeContainer {
        var validator: AbstractTextValidator?
    }
    
    
    // MARK: -  public method
    
    /// 设置验证模式
    func setTextValidator(_ validator: AbstractTextValidator) {
        runtimeContainer = RuntimeContainer()
        runtimeContainer?.validator = validator
    }
    
    /// 验证输入的文本内容
    ///
    /// 数字、字母、邮件 .... 等等
    @discardableResult
    func validate() -> Bool {
        guard let validator = runtimeContainer?.validator else { return false }
        
        var msg = ""
        let isSucc = validator.validate(text ?? "", out: &msg)
        print("[\(type(of: self))] - validate() - isSuccess = \(isSucc); msg = 【\(msg)】")
        return isSucc
    } 
    
}


