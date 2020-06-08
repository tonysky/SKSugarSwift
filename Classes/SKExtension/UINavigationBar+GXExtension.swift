
//
//  UINavigationBar+GXExtension.swift
//  FenxiaoMS
//
//  Created by Sky on 2018/3/2.
//  Copyright © 2018年 lainkai. All rights reserved.
//

import UIKit 

extension UINavigationBar: SelfAware {
    
    static func awake() {
//        UINavigationBar.classInit()
    }
    
    static func classInit() {
//        UINavigationBar.swizzleMethod
    }

//    private static let swizzleMethod: Void = {
//        let originalSel = #selector(layoutSubviews)
//        let swizzledSel = #selector(gx_layoutSubviews)
//        
//        gx_swizzleMethod(UINavigationBar.self, originalSelector: originalSel, swizzleSelector: swizzledSel)        
//    }()
//    
//
//
//    @objc func gx_layoutSubviews() {
//        gx_layoutSubviews()
//        
////        print("UINavigationBar gx_layoutSubviews")
//        
//        if UIDevice.systemVersionF >= 11.0 {
//            self.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
//            
//            for view in self.subviews {
//                if NSStringFromClass(type(of: view)).lowercased().contains("contentView".lowercased()) {
//                    let margin: CGFloat = 5.0
//                    view.layoutMargins = UIEdgeInsetsMake(0, margin, 0, margin + 2)
//                }
//            }
//        }
//    } 


}




