
//
//  UITextField+Extension.swift
//  GXCreditManagement
//
//  Created by Sky on 2018/6/14.
//  Copyright © 2018年 liankai. All rights reserved.
//

import Foundation
import UIKit


/// 数字标点符号集
let punctuationSet: Set = Set(arrayLiteral: "%", "-", "+", "x", "×", "/", ",", "#", "?", ":", "_", "*")

// MARK: - init
extension UITextField {
    
    convenience init(text: String = "", placeholder placeholder_: String, fontSize: CGFloat = 14, isBold: Bool = false, color: UIColor = UIColor.black, alignment: NSTextAlignment = .left, keyboardType kbType: UIKeyboardType = .default/*, showAccessoryView: Bool = false*/) 
    {
        self.init()
        placeholder = placeholder_
        font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        textColor = color
        textAlignment = alignment
        keyboardType = kbType
        /*if showAccessoryView { inputAccessoryView = GXInputAccessoryView(title: "完成") }*/
    }
    
    
    
    
    
    
    
}



// MARK: - attributes
extension UITextField {
    
    func setAttr(inputView inpView: UIView, accessoryView: UIView, keyboardType kbType: UIKeyboardType = .default) {
        inputView = inpView
        inputAccessoryView = accessoryView
        keyboardType = kbType
    }
    
    
    /// 根据 textF 的 keyboardType 检查输入的字符串（如果是 numberPad 或 decimalPad 要过滤掉 搜狗输入法 等键盘上的 ’杂乱符号‘ - punctuation）
    func checkText() -> String {
        let str = text!.trim()
        var temp = str
        
        if keyboardType == .decimalPad || keyboardType == .numberPad {
            if keyboardType == .numberPad {
                temp = str.replace(of: ".", with: "")
            }
            let lastCh = String(str.suffix(1))
            if punctuationSet.contains(lastCh) {
                temp = str.replace(of: lastCh, with: "")
            }
            text = temp
        }
        return temp
    }
    
    
}




