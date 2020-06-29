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

public class SKTextField: UITextView {
    
    // MARK: -  public 
    
    /// placeholder 占位符
    @objc public var placeholder: String = "" { didSet { self.ph.text = placeholder } }
    @objc public var placeholderColor: UIColor = UIColor.gray { didSet { self.ph.textColor = placeholderColor } }
    @objc public var placeholderFont: UIFont = UIFont.systemFont(ofSize: 14) { didSet { self.ph.font = placeholderFont} }
    @objc public var placeholderFontSize: CGFloat = 14 { didSet { self.placeholderFont = UIFont.systemFont(ofSize: placeholderFontSize) } }
    
    /// 是否跟随行数自动调整高度
    @objc public var isAutoHeight: Bool = false
    
    
    
    
    // MARK: -  private
    
    private lazy var ph = UILabel()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        setupNote()
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupNote() {
        NotificationCenter.default.addObserver(self, selector: #selector(txtV_didBeginEditing(_:)), name: UITextView.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(txtV_didChangeEditing(_:)), name: UITextView.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(txtV_didEndEditing(_:)), name: UITextView.textDidEndEditingNotification, object: nil)
    }
    
    private func setupUI() {
        backgroundColor = UIColor(hex: 0xf2f2f2) //test
        
        addSubview(ph)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("SKTextField deinit!")
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
//        print(frame, textContainer.size)
        ph.frame = CGRect(x: 5, y: 3, width: bounds.width - 10, height: bounds.height - 6)
    }  
    
    private func bindPlaceholder() {
        ph.font = placeholderFont
        ph.textColor = placeholderColor
        ph.textAlignment = self.textAlignment
        ph.numberOfLines = 0
        ph.text = placeholder
    }
    

    
    
}


extension SKTextField : UITextViewDelegate {
    
    @objc private func txtV_didBeginEditing(_ note: Notification) {
        
    }
    
    @objc private func txtV_didChangeEditing(_ note: Notification) {
        ph.isHidden = text.count > 0
        
        // 过滤
        checkText { text = $0 }
    }
    
    @objc private func txtV_didEndEditing(_ note: Notification) {
        
    }
    
    
}




// MARK: -  convenience

extension SKTextField {
    
    /// text=""/ fontSize=14/ textColor=black/ isBold=false/ placeholderStr=""/ placeholderFontSize=14/ placeholderColor=gray/ isPlaceholderBold=false/ textAligment=.left
    convenience init (_ text: String = "", fontSize: CGFloat = 14, textColor: UIColor = UIColor.black, isBold: Bool = false, 
                      placeholder: String = "", placeholderFontSize: CGFloat = 14, placeholderColor: UIColor = UIColor.gray, isPlaceholderBold: Bool = false, 
                      textAlignment: NSTextAlignment = .left)
    {
        self.init()
        
        self.text = text
        self.textColor = textColor
        self.font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        self.textAlignment = textAlignment
        
        // placeholder
        self.placeholder = placeholder
        self.placeholderFontSize = placeholderFontSize
        self.placeholderFont = isPlaceholderBold ? UIFont.boldSystemFont(ofSize: placeholderFontSize) : UIFont.systemFont(ofSize: placeholderFontSize)
        self.placeholderColor = placeholderColor
        
        self.bindPlaceholder()
    }
    
    /// text=""/ fontSize=14/ textColorHex/ isBold=false/ placeholderStr=""/ placeholderFontSize=14/ placeholderColorHex/ isPlaceholderBold=false/ textAligment=.left
    convenience init (_ text: String = "", fontSize: CGFloat = 14, textColorHex: Int32, isBold: Bool = false, 
                      placeholder: String = "", placeholderFontSize: CGFloat = 14, placeholderColorHex: Int32, isPlaceholderBold: Bool = false, 
                      textAlignment: NSTextAlignment = .left)
    {
        self.init(text, fontSize: fontSize, textColor: UIColor(hex: textColorHex), isBold: isBold, 
                  placeholder: placeholder, placeholderFontSize: placeholderFontSize, placeholderColor: UIColor(hex: placeholderColorHex), isPlaceholderBold: isPlaceholderBold, 
                  textAlignment: textAlignment)
    }
    
}


// MARK: -  SystemInput 过滤系统输入法输入过程中的乱码问题

extension SKTextField {
    
    public func checkText(_ handle: (_ textStr: String) -> ()) {
//        print("text =", text ?? "")
        guard let _ = self.markedTextRange else {
                handle(text)
                return
        } 
//        print("----markedRange =", markedRange)
    }
}




