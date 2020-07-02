//
//  ViewController.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/6/8.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController viewDidLoad")
        
        setupUI()
    }


    
    
    
    private func setupUI() {
        view.backgroundColor = UIColor.white
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "测试首页", style: .plain, target: self, action: #selector(testHomeAction))
    }
    
}



extension ViewController {
    
    @objc private func testHomeAction() {
        navigationController?.pushViewController(SKSugarSwiftExampleTestController(), animated: true)
    }
    
    
}


