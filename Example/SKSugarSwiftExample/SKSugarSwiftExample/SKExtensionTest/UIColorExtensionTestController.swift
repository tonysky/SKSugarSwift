//
//  UIColorExtensionTestController.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/6/28.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit

class UIColorExtensionTestController: BaseViewController {
    
    private lazy var label = UILabel(sk_text: "哈哈哈", fontSize: 20, color: UIColor.purple, alignment: .right, isBold: true)

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        label.frame = CGRect(x: 20, y: 100, width: 200, height: 50)
    }
    
    
    
    override func setupUI() {
        super.setupUI()
        
        testUI()
        label.backgroundColor = UIColor(hexStr: "ff0000")
    }
    
    
    
    func testUI() {
        view.addSubview(label)
        label.backgroundColor = UIColor.orange
    }

}
