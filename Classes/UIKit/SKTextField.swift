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
    @objc public var placeholder: String { didSet { self.ph.text = placeholder } }
    
    /// 是否跟随行数自动调整高度
    public var isAutoHeight: Bool = false
    
    
    
    
    // MARK: -  private
    
    private lazy var ph = UILabel()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        placeholder = ""
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
        ph.frame = bounds
    }  
    
    private func bindPlaceholder() {
        ph.font = self.font
        ph.textColor = self.textColor
        ph.textAlignment = self.textAlignment
        ph.numberOfLines = 0
        ph.text = placeholder
    }
    

    
    
    // MARK: -  override
    
    public override var font: UIFont? { didSet { self.ph.font = font } }
    
    public override var textColor: UIColor? { didSet { self.ph.textColor = textColor } }
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
    
    convenience init (_ text: String = "", fontSize: CGFloat = 14, textColor: UIColor = UIColor.black, placeholder str: String = "", isBold: Bool = false, textAlignment: NSTextAlignment = .left)
    {
        self.init()
        
        self.text = text
        self.textColor = textColor
        self.font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        self.textAlignment = textAlignment
        
        // placeholder
        self.placeholder = str
        self.bindPlaceholder()
        self.ph.text = str
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




