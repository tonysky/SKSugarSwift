//
//  SKUIKitHomeTableViewController.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/6/28.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit

class SKUIKitHomeTableViewController: UIViewController {
    
    public var dataSource: [(String, String)]! {
        didSet {
            list = dataSource
        }
    }
    
    private var list: [(String, String)]!
    
    private lazy var skUIKitHomeTv: UITableView = {
        let tv = UITableView(frame: view.bounds, style: .plain)
        
        tv.delegate = self
        tv.dataSource = self
        
        tv.rowHeight = 44;
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        
        return tv
    }()

    
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
        
        view.addSubview(skUIKitHomeTv)
    }
    
    func initVariables_controller() {
        list = [
            ("SKTextField文本框测试", "SKTextFieldTestController")
            
        ]
    }
    
    
    
    
    
    
    


}

private let cellID = "cellID"

extension SKUIKitHomeTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { list.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = list[indexPath.row].0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let vcClass = NSClassFromString(Bundle.main.namespaceDot + list[indexPath.row].1) as? UIViewController.Type
            else {
                print("vcClass == nil !")
                return
        }
        
        let vc = vcClass.init()
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}




















