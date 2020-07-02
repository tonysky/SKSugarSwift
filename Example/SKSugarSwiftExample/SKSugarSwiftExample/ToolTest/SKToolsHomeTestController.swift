//
//  SKToolsHomeTestController.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/7/2.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit

class SKToolsHomeTestController: SKUIKitHomeTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = [
            ("SKNetworkManager网络工具类测试", "SKNetworkManagerTestController")
            
        ]
    }

}
