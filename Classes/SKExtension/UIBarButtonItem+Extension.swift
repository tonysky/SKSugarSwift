//
//  UIBarButtonItem+Extension.swift
//  FenxiaoMS
//
//  Created by Sky on 2018/2/6.
//  Copyright © 2018年 lainkai. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 根据 title 创建 barButtonItem
    ///
    /// - Parameters:
    ///   - title: title
    ///   - target: Target
    ///   - action: Selector
    convenience init(gxtitle: String, color: UIColor, target: Any?, action: Selector) 
    {
        let button = UIButton(title: gxtitle, fontSize: 14, titleColorNormal: color, titleColorHighlighted: UIColor.lightGray)
        button.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: button)
    }
    
    /// 根据 imgNameNormal/ imgNameHighlighted/ action 创建 barButtonItem
    ///
    /// - Parameters:
    ///   - imgNameNormal: 默认状态图片
    ///   - imgNameHighlighted: 高亮状态图片
    ///   - target: target
    ///   - action: Selector
    convenience init(imgNameNormal: String, imgNameHighlighted: String, target: Any?, action: Selector) 
    {
        let button = UIButton(imageNameNormal: imgNameNormal, imageNameHighlighted: imgNameHighlighted)
        button.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: button)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}


//extension UIBarButtonItem {
//    
//
//    
//    
//    
//    
//}







