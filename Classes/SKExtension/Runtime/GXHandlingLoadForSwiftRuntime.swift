//
//  GXHandlingLoadForSwiftRuntime.swift
//
//  Created by Sky on 2018/3/2.
//  

import Foundation
import UIKit

protocol SelfAware: class {
    static func awake()
}


class NothingToSeeHere {
    
    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? SelfAware.Type)?.awake()
        }
//        types.deallocate(capacity: typeCount)
        types.deallocate()
    }
}



extension UIApplication {
    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()
    
    open override var next: UIResponder? {
        UIApplication.runOnce
        
        return super.next
    }
}




extension NSObject {
    
    /// 交换方法 - gx_swizzleMethod
    static func gx_swizzleMethod(_ cls: AnyClass, originalSelector: Selector, swizzleSelector: Selector){
        
        let originalMethod = class_getInstanceMethod(cls, originalSelector)!
        let swizzledMethod = class_getInstanceMethod(cls, swizzleSelector)!
        
        let didAddMethod = class_addMethod(cls,
                                           originalSelector,
                                           method_getImplementation(swizzledMethod),
                                           method_getTypeEncoding(swizzledMethod))
        if didAddMethod {
            class_replaceMethod(cls,
                                swizzleSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod,
                                           swizzledMethod)
        }
    }
}

















