//
//  UIColor+GXExtension.swift
//  XJCFMall
//
//  Created by Tony on 2018/3/4.
//  Copyright © 2018年 Tony. All rights reserved.
//

import UIKit

extension UIColor {
    
    
    /// 根据 r/g/b 的数值创建 UIColor  
    ///
    /// - Parameters:
    ///   - r: red
    ///   - g: green
    ///   - b: blue
    ///   - alpna: alpha
    convenience init(gx_red: CGFloat, gx_green: CGFloat, gx_blue: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: gx_red / 255.0, green: gx_green / 255.0, blue: gx_blue / 255.0, alpha: 1.0)
    }
    
    
    /// 根据 16进制 颜色创建 UIColor 对象 
    ///
    /// - Parameter hexStr: 16进制颜色 - 0xFFFFFF
    convenience init(gx_hex: UInt32) {
        
        let red = (gx_hex & 0xFF0000) >> 16 
        let green = (gx_hex & 0x00FF00) >> 8
        let blue = (gx_hex & 0x0000FF)
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
//    /// 根据 16进制 颜色字符串 创建 UIColor 对象
//    ///
//    /// - Parameter hexStr: 16进制 颜色字符串 - "#FFFFFF"
//    convenience init?(hexStr: String) {
//        self.init()
//        
//        let str: String = hexStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//        if str.count < 6 { return nil }
//        
//        if str.count == 8 && str.hasPrefix("0x") ||
//            str.count == 7 && str.hasPrefix("#")
//        {
//            let result = String(str.suffix(6))
//            // 将字符串转成十六进制
//            
//        } 
//        return nil
//    }
    
    
    
    
    
    
    
    
}


extension UIColor {
    
    class func random() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0, 
                       green: CGFloat(arc4random_uniform(256)) / 255.0, 
                       blue: CGFloat(arc4random_uniform(256)) / 255.0, 
                       alpha: 1.0)
    }
    
    /// 森林绿
    class var forestGreen: UIColor {
        return UIColor(red: 34.0 / 255.0, 
                       green: 139.0 / 255.0, 
                       blue: 34.0 / 255.0, 
                       alpha: 1.0)
    }
    
    /// 草绿色
    class var grassGreen: UIColor {
        return UIColor(red: 153.0 / 255.0, 
                       green: 204.0 / 255.0, 
                       blue: 51.0 / 255.0, 
                       alpha: 1.0)
    }
    
}






