//
//  SKTextFieldTestController.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/6/28.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit

class SKTextFieldTestController: BaseViewController {
    
    
    private lazy var txt: SKTextField = SKTextField(frame: CGRect(x: 20, y: 100, width: 100, height: 40))
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    override func setupUI() {
        super.setupUI()
        
        view.addSubview(txt)
        txt.backgroundColor = UIColor.orange
    }

}
