//
//  UITableViewExtensionTestController.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/8/5.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit

class UITableViewExtensionTestController: BaseViewController {
    
    private let cellID = "hahacellid"
    
    private lazy var tableView: UITableView = UITableView(frame: CGRect(x: 50, y: 20, width: 300, height: 400), delegate: self, rowHeight: 50, registerCellClass: UITableViewCell.self, cellReuseIdentifier: cellID) { (tv) in
        tv.backgroundColor = UIColor.purple
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
    
    
    
    override func setupUI() {
        super.setupUI()
        
        view.addSubview(tableView)
    }
    
    
    
   
    
}


extension UITableViewExtensionTestController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 5 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
    
    
    
    
}

