//
//  SKSugarSwiftExampleTestController.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/6/28.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit


/*
 SKSugarSwift 测试首页
 */

class SKSugarSwiftExampleTestController: SKUIKitHomeTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = [
            ("SKUIKit自定义控件测试", "SKUIKitHomeTableViewController"),
            ("SKExtension测试", "SKExtensionHomeTestController")
        ]
    }

}
