//
//  SKNetworkManagerTestController.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/7/2.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit

class SKNetworkManagerTestController: BaseViewController {

    private var txtToken: UITextField!
    private var btnCheckToken: UIButton!
    private var lblMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let token = UserDefaults.standard.value(forKey: "token") as? String ?? ""
        txtToken.text = token.count == 0 
            ? "swC9V-ffE_oDngdFhM2YaPQAC9uQB8iS4Ooetk5R7WXqwRDsHBmhD2exT5JR5omh" 
            : token
    }
    
    
    @objc private func btnCheckTokenClick(_ sender: Any) {
        checkToken()
    }
    
    override func setupUI() {
        super.setupUI()
        
        txtToken = UITextField(frame: CGRect(x: 10, y: 100, width: UIScreen.main.bounds.width-20, height: 40))
        view.addSubview(txtToken)
        txtToken.layer.borderColor = UIColor.gray.cgColor
        txtToken.layer.borderWidth = 1.0
        
        btnCheckToken = UIButton(frame: CGRect(x: 10, y: 160, width: txtToken.bounds.width, height: 44))
        view.addSubview(btnCheckToken)
        btnCheckToken.backgroundColor = UIColor.orange
        btnCheckToken.setTitle("check token", for: .normal)
        btnCheckToken.setTitleColor(UIColor.black, for: .normal)
        btnCheckToken.addTarget(self, action: #selector(btnCheckTokenClick(_:)), for: .touchUpInside)
        
        lblMsg = UILabel(frame: CGRect(x: 10, y: 220, width: txtToken.bounds.width, height: 150))
        view.addSubview(lblMsg)
        lblMsg.backgroundColor = UIColor(hex: 0xf2f2f2)
    }
    
    
    override func initVariables_controller() {
        super.initVariables_controller()
        
    }
    
    
    private func checkToken() 
    {
        print("checkToken") 
        let token = txtToken.text?.count == 0 
            ? UserDefaults.standard.value(forKey: "token") as? String ?? ""
            : txtToken.text!
        
        let url = "https://devsg.quanxiyun.net/login/login/checkToken"
        let deviceID = "191e35f7e02fa1a4110"
        let params: [String : Any] = [
            "body": [
                "deviceId": deviceID
            ],
            "channel": "iOS",
            "token": token,
            "version": "3.1.1"
        ]
        
        SKNetworkManager.shared .request(method: .POST, url: url, params: params, { (respDict) in
            print("success")
            print(".")
            
            let codeStr = respDict["code"] as? String ?? ""
            
            if codeStr == "0000" {
                let newToken = respDict["body"]!["token"]! as! String
                UserDefaults.standard.setValue(newToken, forKey: "token")
                self.txtToken.text = newToken
                self.lblMsg.text = "请求成功！"
            } else if codeStr == "1100001" || codeStr == "1100002" {
                // token失效
                print("errorMsg =", respDict["msg"] ?? "")
                UserDefaults.standard.setValue("", forKey: "token")
                self.txtToken.text = ""
                self.lblMsg.text = respDict["msg"] as? String ?? "--"
                
            } else {
                print("errorMsg =", respDict["msg"] ?? "")
                self.txtToken.text = ""
                self.lblMsg.text = respDict["msg"] as? String ?? "--"
            }
            
        }) { (error) in
            print("error = \(error)")
            self.txtToken.text = ""
            self.lblMsg.text = error.localizedDescription
            UserDefaults.standard.setValue("", forKey: "token")
        }
    }
    

    
}
