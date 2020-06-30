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
    @objc public var placeholder: String = "" { didSet { 
        self.ph.text = placeholder
        self.singleLineLabel.text = "字"
        } }
    @objc public var placeholderColor: UIColor = UIColor.gray { didSet { 
        self.ph.textColor = placeholderColor 
        self.singleLineLabel.textColor = placeholderColor
        } }
    @objc public var placeholderFont: UIFont = UIFont.systemFont(ofSize: 14) { didSet { 
        self.ph.font = placeholderFont
        self.singleLineLabel.font = placeholderFont
        } }
    @objc public var placeholderFontSize: CGFloat = 14 { didSet { self.placeholderFont = UIFont.systemFont(ofSize: placeholderFontSize) } }
    
    /// 是否跟随行数自动调整高度
    @objc public var isAutoHeight: Bool = false
    
    
    
    
    // MARK: -  private
    
    /// 占位符Label
    private lazy var ph = UILabel()
    private lazy var singleLineLabel = UILabel()
    
    private var min_height: CGFloat = 0.0
    private var newTextFrame = CGRect.zero
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        min_height = frame.height;
        
        setupNote()
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath != "text" { return }
        guard let change = change else { return }
        
        ph.isHidden = (change[NSKeyValueChangeKey.newKey] as! String).count > 0
    }
    
    
    private func setupNote() {
        NotificationCenter.default.addObserver(self, selector: #selector(txtV_didBeginEditing(_:)), name: UITextView.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(txtV_didChangeEditing(_:)), name: UITextView.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(txtV_didEndEditing(_:)), name: UITextView.textDidEndEditingNotification, object: nil)
        
        addObserver(self, forKeyPath: "text", options: .new, context: nil)
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
//        backgroundColor = UIColor.gray //test
        
        addSubview(ph)
//        ph.backgroundColor = UIColor(hex: 0xf5f5f5) //test
        
//        addSubview(singleLineLabel) //test
//        singleLineLabel.backgroundColor = UIColor.red //test
//        singleLineLabel.alpha = 0.2 //test
//        singleLineLabel.isHidden = true //test
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("SKTextField deinit!")
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        DispatchQueue.main.async { self.updatePlaceholderFrame() }
        if isAutoHeight && newTextFrame != CGRect.zero {
            self.frame = newTextFrame
        }
    }  
    
    private func bindPlaceholder() {
        ph.font = placeholderFont
        ph.textColor = placeholderColor
        ph.textAlignment = self.textAlignment
        ph.numberOfLines = 0
        ph.text = placeholder
        
        bindSingleLineLabel()
    }
    private func bindSingleLineLabel() {
        singleLineLabel.font = placeholderFont
        singleLineLabel.textAlignment = self.textAlignment
        singleLineLabel.numberOfLines = 1
        singleLineLabel.text = "字"
    }
    
    private func updatePlaceholderFrame() 
    {
        let strRect: CGRect = placeholder.boundingRect(with: CGSize(width: bounds.width - 10, height: bounds.height - 7), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: placeholderFont], context: nil)
        let singleLabelSize = singleLineLabel.textRect(forBounds: CGRect(x: 0, y: 0, width: 50, height: 100), limitedToNumberOfLines: 0).size
        
        let cursorRect = getCursorRect()
        let singleLineLabel_minY = cursorRect.minY + (cursorRect.height - singleLabelSize.height) / 2;
        singleLineLabel.frame = CGRect(x: 6, y: singleLineLabel_minY, width: strRect.width + 2, height: singleLabelSize.height)
        
        let avg = strRect.height / singleLabelSize.height
        let lines = Int(avg + 0.5)
        let each_height = strRect.height / CGFloat(lines)
        let ph_minY = singleLineLabel.frame.minY + (singleLabelSize.height - each_height) / 2;
        ph.frame = CGRect(x: singleLineLabel.frame.minX, y: ph_minY, width: strRect.width + 2, height: strRect.height + 2)
    }
//    {
//        print("\n------------")
//        
//        let strRect: CGRect = placeholder.boundingRect(with: CGSize(width: bounds.width - 10, height: bounds.height - 7), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: placeholderFont], context: nil)
//        print("strRect =", strRect)
//        
//        let singleLabelSize = singleLineLabel.textRect(forBounds: CGRect(x: 0, y: 0, width: 50, height: 100), limitedToNumberOfLines: 0).size
//        print("singleLabelSize =", singleLabelSize)
//        
////        let phSize = ph.textRect(forBounds: CGRect(x: 0, y: 0, width: bounds.width - 10, height: bounds.height - 14), limitedToNumberOfLines: 0).size
////        print("phSize =", phSize) //(100.0, 35.0) (86.0, 21.0)
//        
//        let cursorRect = getCursorRect()
//        print("cursorRect =", cursorRect)
//        
//        let singleLineLabel_minY = cursorRect.minY + (cursorRect.height - singleLabelSize.height) / 2;
//        singleLineLabel.frame = CGRect(x: 6, y: singleLineLabel_minY, width: strRect.width + 2, height: singleLabelSize.height)
//        print("singleLineLabel_minY =", singleLineLabel_minY, "; singleLineLabel.frame =", singleLineLabel.frame)
//        
//        let avg = strRect.height / singleLabelSize.height
//        let lines = Int(avg + 0.5)
//        print("\navg =", avg, "; lines =", lines)
//        let each_height = strRect.height / CGFloat(lines)
//        print("each_height =", each_height)
//        
//        let ph_minY = singleLineLabel.frame.minY + (singleLabelSize.height - each_height) / 2;
//        ph.frame = CGRect(x: singleLineLabel.frame.minX, y: ph_minY, width: strRect.width + 2, height: strRect.height + 2)
//        print("ph_minY =", ph_minY, "; phFrame =", ph.frame)
//    }
    
    
}

// MARK: -  delegate
extension SKTextField : UITextViewDelegate {
    
    @objc private func txtV_didBeginEditing(_ note: Notification) {
        
    }
    
    @objc private func txtV_didChangeEditing(_ note: Notification) {
        ph.isHidden = text.count > 0
        
        // 过滤
        checkText { _ in
//            text = $0
            
            // 自动高度处理
            isAutoHeight ? processAutoHeight() : ()
        }
    }
    
    @objc private func txtV_didEndEditing(_ note: Notification) {
        
    }
    
    
    // MARK: -  mehtod
    
    /// 文本框自动高度处理
    private func processAutoHeight() {
        if contentSize.height > bounds.height + 10 || contentSize.height < bounds.height - 10
        { 
            //需要修改高度
//            print("modify height")
            let newHeight = self.contentSize.height;
            var newFrame = self.frame
            newFrame.size.height = newHeight
            self.newTextFrame = newFrame
            self.frame = newFrame
        } 
    }
    
//    /// 获取光标视图
//    private func getCursorView() {
//        print("textView.subviews =", subviews)
//        for subv in subviews {
//            print("subv.subviews =", subv.subviews)
//            guard let cls = NSClassFromString("_UITextContainerView") else {
//                continue
//            }
//            
//            if subv.isMember(of: cls) {
//                print("containerView.subviews =", subv.subviews)
//                for sub in subv.subviews {
//                    guard let cls_canvas = NSClassFromString("_UITextViewCanvasView") else {
//                        continue
//                    }
//                    
//                    if sub.isKind(of: cls_canvas) {
//                        let canvas = sub
//                        DispatchQueue.main.async {
//                            print(canvas.subviews)
//                        }
//                    }
//                }
//            }
//        }
//    }
    
    private func getCursorRect() -> CGRect {
        // 获取光标位置
        guard let textRange = selectedTextRange else { return CGRect.zero }
        let cursorRect = caretRect(for: textRange.end)
//        print(cursorRect)
        
        return cursorRect
    }
    
}




// MARK: -  convenience

extension SKTextField {
    
    /// text=""/ fontSize=14/ textColor=black/ isBold=false/ placeholderStr=""/ placeholderFontSize=14/ placeholderColor=gray/ isPlaceholderBold=false/ textAligment=.left/ isAutoHeight=false
    @objc public convenience init (sk_text text: String = "", fontSize: CGFloat = 14, textColor: UIColor = UIColor.black, isBold: Bool = false, 
                      placeholder: String = "", placeholderFontSize: CGFloat = 0, placeholderColor: UIColor = UIColor.gray, isPlaceholderBold: Bool = false, 
                      textAlignment: NSTextAlignment = .left, isAutoHeight: Bool = false)
    {
        self.init()
        
        self.text = text
        self.textColor = textColor
        self.font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        self.textAlignment = textAlignment
        
        // placeholder
        self.placeholder = placeholder
        self.placeholderFontSize = placeholderFontSize == 0 ? fontSize : placeholderFontSize
        self.placeholderFont = isPlaceholderBold ? UIFont.boldSystemFont(ofSize: self.placeholderFontSize) : UIFont.systemFont(ofSize: self.placeholderFontSize)
        self.placeholderColor = placeholderColor
        
        self.bindPlaceholder()
        
        // autoHeight
        self.isAutoHeight = isAutoHeight
    }
    
    /// text=""/ fontSize=14/ textColorHex/ isBold=false/ placeholderStr=""/ placeholderFontSize=14/ placeholderColorHex/ isPlaceholderBold=false/ textAligment=.left/ isAutoHeight=false
    @objc public convenience init (sk_text text: String = "", fontSize: CGFloat = 14, textColorHex: Int32, isBold: Bool = false, 
                      placeholder: String = "", placeholderFontSize: CGFloat = 0, placeholderColorHex: Int32, isPlaceholderBold: Bool = false, 
                      textAlignment: NSTextAlignment = .left, isAutoHeight: Bool = false)
    {
        self.init(sk_text: text, fontSize: fontSize, textColor: UIColor(hex: textColorHex), isBold: isBold, 
                  placeholder: placeholder, placeholderFontSize: placeholderFontSize, placeholderColor: UIColor(hex: placeholderColorHex), isPlaceholderBold: isPlaceholderBold, 
                  textAlignment: textAlignment, isAutoHeight: isAutoHeight)
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








