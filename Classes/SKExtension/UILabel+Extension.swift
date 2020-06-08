//
//  UILabel+Extension.swift
//  GXCreditManagement
//
//  Created by Sky on 2018/6/1.
//  Copyright © 2018年 liankai. All rights reserved.
//

import UIKit

extension UILabel {    
    
    /// gx_根据 text/ fontSize/ color/ alignment/ isBold/ 创建 label
    ///
    /// - Parameters:
    ///   - gx_text: text
    ///   - fontSize: fontSize
    ///   - color: textColor
    ///   - alignment: textAlignment
    ///   - isBold: 当前字体是否加粗
    ///   - tapAction: 点击时的回调
    convenience init(_ gx_text: String, fontSize: CGFloat = 14, color: UIColor = UIColor.black, alignment: NSTextAlignment = .left, isBold: Bool = false)
    {
        self.init(gx_text, fontSize: fontSize, color: color, alignment: alignment, isBold: isBold, isFredom: false)
    }
    
    /// gx_根据 text/ fontSize/ color/ alignment/ isBold/ (^tapAction) 创建 label
    ///
    /// - Parameters:
    ///   - gx_text: text
    ///   - fontSize: fontSize
    ///   - color: textColor
    ///   - alignment: textAlignment
    ///   - isBold: 当前字体是否加粗
    ///   - tapAction: 点击时的回调
    convenience init(_ gx_text: String, fontSize: CGFloat = 14, color: UIColor = UIColor.black, alignment: NSTextAlignment = .left, isBold: Bool = false, tapAction: @escaping () -> Void = {})
    {
        self.init(gx_text, fontSize: fontSize, color: color, alignment: alignment, isBold: isBold, tapAction: tapAction, isFredom: false)
    }
    
    
    
    
    /// gx_根据 text/ fontSize/ color/ alignment/ isBold/ isFredom 创建 label
    ///
    /// - Parameters:
    ///   - gx_text: text
    ///   - fontSize: fontSize
    ///   - color: textColor
    ///   - alignment: textAlignment
    ///   - isBold: 当前字体是否加粗
    ///   - tapAction: 点击时的 closure 回调
    ///   - isFredom: 是否不根据内容自动撑起（true - 自由大小，不根据内容撑起；false - sizeToFit根据内容撑起）
    convenience init(_ gx_text: String, fontSize: CGFloat = 14, color: UIColor = UIColor.black, alignment: NSTextAlignment = .left, isBold: Bool = false, isFredom: Bool)
    {
        self.init()
        
        text = gx_text
        textColor = color
        font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        
        textAlignment = alignment
        
        if !isFredom {
            sizeToFit()
        }
    }
    
    /// gx_根据 text/ fontSize/ color/ alignment/ isBold/ (^tapAction)/ isFredom 创建 label
    ///
    /// - Parameters:
    ///   - gx_text: text
    ///   - fontSize: fontSize
    ///   - color: textColor
    ///   - alignment: textAlignment
    ///   - isBold: 当前字体是否加粗
    ///   - tapAction: 点击时的 closure 回调
    ///   - isFredom: 是否不根据内容自动撑起（true - 自由大小，不根据内容撑起；false - sizeToFit根据内容撑起）
    convenience init(_ gx_text: String, fontSize: CGFloat = 14, color: UIColor = UIColor.black, alignment: NSTextAlignment = .left, isBold: Bool = false, tapAction: @escaping () -> Void = {}, isFredom: Bool)
    {
        self.init()
        
        text = gx_text
        textColor = color
        font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        
        textAlignment = alignment
        
        if !isFredom {
            sizeToFit()
        }
        
        addTapGestureAction(tapAction: tapAction)
    }
    
    
}


typealias TapClosure = () -> Void

// MARK: - tapAction
extension UILabel {
    
    // MARK:- RuntimeKey   动态绑属性
    private struct RuntimeKey {
//        static let kTap = UnsafeRawPointer.init(bitPattern: "kTap".hashValue)
        static var kTap = "kTap"
    }
    
    var container: ClosureContainer? {
        get {
            return objc_getAssociatedObject(self, &RuntimeKey.kTap) as? ClosureContainer
        }
        set {
            objc_setAssociatedObject(self, &RuntimeKey.kTap, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc private func tapAction(_ tap: UITapGestureRecognizer) {   
        guard let ct = container 
            else {
            return
        }
        ct.tapClosure?()
    }
    
    func addTapGestureAction(tapAction: @escaping () -> Void) {
        container = ClosureContainer()
        container?.tapClosure = tapAction
        
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction(_:)))
        addGestureRecognizer(tap)
    }
    
    
    /// 闭包容器类
    class ClosureContainer {
        var tapClosure: TapClosure?
    }
    
}




