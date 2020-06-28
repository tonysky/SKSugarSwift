//
//  SKExtensionHomeTestController.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/6/28.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit

class SKExtensionHomeTestController: SKUIKitHomeTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = [
            ("UIColorExtension测试", "UIColorExtensionTestController")
            
        ]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
