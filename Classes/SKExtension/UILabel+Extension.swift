//
//  UILabel+Extension.swift
//  GXCreditManagement
//
//  Created by Sky on 2018/6/1.
//  Copyright © 2018年 liankai. All rights reserved.
//

import UIKit

public protocol ColorSelectorable {
    
}

public extension UILabel {    
    
    /// gx_根据 text/ fontSize/ color/ alignment/ isBold/ isFreedom/ (^tapAction) 创建 label
    ///
    /// - Parameters:
    ///   - gx_text: text
    ///   - fontSize: fontSize
    ///   - color: textColor
    ///   - alignment: textAlignment
    ///   - isBold: 当前字体是否加粗
    ///   - isFreedom: 是否不根据内容自动撑起（true - 自由大小，不根据内容撑起；false - sizeToFit根据内容撑起）
    ///   - tapAction: 点击时的 closure 回调
    convenience init(sk_text: String, fontSize: CGFloat = 14, color: UIColor = UIColor.black, alignment: NSTextAlignment = .left, isBold: Bool = false, isFreedom: Bool = false, tapAction: (() -> Void)? = nil)
    {
        self.init()
        
        set(sk_text: sk_text, fontSize: fontSize, color: color, alignment: alignment, isBold: isBold)
        
        if !isFreedom { sizeToFit() }
        if let action = tapAction { addTapGestureAction(tapAction: action) }
    }
    
    /// gx_根据 text/ fontSize/ colorHex(UInt32)/ alignment/ isBold/ isFreedom/ (^tapAction) 创建 label
    ///
    /// - Parameters:
    ///   - gx_text: text
    ///   - fontSize: fontSize
    ///   - color: textColor
    ///   - alignment: textAlignment
    ///   - isBold: 当前字体是否加粗
    ///   - isFreedom: 是否不根据内容自动撑起（true - 自由大小，不根据内容撑起；false - sizeToFit根据内容撑起）
    ///   - tapAction: 点击时的 closure 回调
    convenience init(_ sk_text: String, fontSize: CGFloat = 14, colorHex: UInt32 = 0x000000, alignment: NSTextAlignment = .left, isBold: Bool = false, isFreedom: Bool = false, tapAction: (() -> Void)? = nil)
    {
        self.init()
        
        set(sk_text: sk_text, fontSize: fontSize, colorHex: colorHex, alignment: alignment, isBold: isBold)
        
        if !isFreedom { sizeToFit() }
        if let action = tapAction { addTapGestureAction(tapAction: action) }
    }
}

// MARK: -  set attrs
public extension UILabel { 
    
    func set(sk_text: String, fontSize: CGFloat, colorHex: UInt32, alignment: NSTextAlignment, isBold: Bool) {
        set(sk_text: sk_text, fontSize: fontSize, color: UIColor(hex: Int32(colorHex)), alignment: alignment, isBold: isBold)
    }
    
    
    func set(sk_text: String, fontSize: CGFloat, color: UIColor, alignment: NSTextAlignment, isBold: Bool) {
        text = sk_text
        textColor = color
        textAlignment = alignment
        font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
    }
    
    
}


fileprivate extension UIColor {
    
    convenience init (_ hex: UInt32) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0, 
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0, 
            blue: CGFloat(hex & 0x0000FF) / 255.0, 
            alpha: 1
        )
    }
}



public typealias TapClosure = () -> Void

// MARK: - tapAction
public extension UILabel {
    
    // MARK:- RuntimeKey   动态绑属性
    private struct RuntimeKey {
//        static let kTap = UnsafeRawPointer.init(bitPattern: "kTap".hashValue)
        static var kTap = "kTap"
    }
    
    fileprivate var runtimeContainer: ClosureContainer? {
        get {
            return objc_getAssociatedObject(self, &RuntimeKey.kTap) as? ClosureContainer
        }
        set {
            if runtimeContainer != nil { return }
            objc_setAssociatedObject(self, &RuntimeKey.kTap, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc private func tapAction(_ tap: UITapGestureRecognizer) {   
        guard let ct = runtimeContainer else { return }
        ct.tapClosure?()
    }
    
    func addTapGestureAction(tapAction: @escaping () -> Void) {
        runtimeContainer = ClosureContainer()
        runtimeContainer?.tapClosure = tapAction
        
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction(_:)))
        addGestureRecognizer(tap)
    }
    
    
    /// 闭包容器类
    fileprivate class ClosureContainer {
        var tapClosure: TapClosure?
    }
    
}




