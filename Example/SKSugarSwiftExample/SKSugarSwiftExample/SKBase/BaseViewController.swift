//
//  BaseViewController.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/6/28.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        
        initVariables_controller()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
    }
    

    
    
    
    
    
    // MARK: -  deinit
    
    deinit {
        print("deinit!")
    }
    
    //MARK: - Actions
    
    
    
    //MARK: - delegates
    
    
    
    
    //MARK: - methods
    
    
    
    //MARK: - setupUI
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        
    }
    
    func initVariables_controller() {
        
    }
    
    
    
    
    
    
    


}
