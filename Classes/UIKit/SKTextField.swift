//
//  SKTextField.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/6/28.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit

/*
 可自动换行文本框 SKTextField
 
 - 自动换行，并且高度自动跟随行数变化
 */

class SKTextField: UITextView {
    
    private lazy var txtV: UITextView = {
       let v = UITextView()
        
        
        return v
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    public func setupUI() {
        backgroundColor = UIColor.purple //test
        
        
        
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        txtV.frame = bounds
    }  
    
    
    
//    override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
//        switch controlEvents {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
//    }

}


extension SKTextField : UITextViewDelegate {
    
    
    
    
}



