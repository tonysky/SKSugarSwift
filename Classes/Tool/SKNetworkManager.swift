//
//  SKNetworkManager.swift
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/7/2.
//  Copyright © 2020 Sky. All rights reserved.
//

import UIKit
import Foundation



public enum NetworkMethod : String {
    case GET = "GET"
    case POST = "POST"
}

public typealias SuccessHandle = ((_ dict: Dictionary<String, AnyObject>) -> ())
public typealias FailuerHandle = ((_ error: Error) -> ())

/// 网络管理类
@objcMembers public class SKNetworkManager : NSObject {
    
    /// 单例方法
    public static let shared = SKNetworkManager()
    
    public var success: SuccessHandle!
    public var failure: FailuerHandle!
    
    
    
    // MARK: -  private
    
    private var urlSession: URLSession!
    private var urlQueue: OperationQueue!
    
    private override init() {
        super.init()
        initializeVariables()
    }
    
    
    private func initializeVariables() {
        self.urlQueue = OperationQueue()
        let config = URLSessionConfiguration.default
        self.urlSession = URLSession(configuration: config, delegate: self, delegateQueue: urlQueue)
    }
    
    
    private func getRequest(method: NetworkMethod, url: URL, param: [String: Any]) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = getHttpHeader()
        request.timeoutInterval = 15
        
        request.httpBody = getHttpBody(param)
        
        return request
    }
    
    private func getHttpHeader() -> [String: String] {
        [
            "Content-Type": "application/json"
        ]
    }
    
    private func getHttpBody(_ params: [String: Any]) -> Data? {
        var data: Data? = nil
        do {
            data = try JSONSerialization.data(withJSONObject: params as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            print("error =", error)
        }        
        
        return data
    }
    
}




//// MARK: - URLSessionDataDelegate
extension SKNetworkManager : URLSessionDataDelegate {
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        print("------didReceive response： time =", NSDate(), "; response =", response)
        completionHandler(.allow)
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("------didReceive data： time =", NSDate(), "; response =", dataTask.response ?? "-")
        
        do {
            let obj = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)            
            print("responseDict = \(obj), url = \(dataTask.response?.url?.absoluteString ?? "-")")
            if let dict = (obj as AnyObject) as? Dictionary<String, AnyObject> {
                if let success = success { DispatchQueue.main.async { success(dict) } }
            } else {
                print("response 不是 Dictionary 类型！ type = \(type(of: obj))")
            }
        } catch {
            print(error)
            if let failure = failure { DispatchQueue.main.async { failure(error) } }
        }
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let error = error else { return }
        print("------didCompleteWithError： time =", NSDate(), "; response =", task.response ?? "-", "; error =", error)
        if let failure = failure { DispatchQueue.main.async { failure(error) } }
    }
    
    
}


// MARK: -  reqeust

public extension SKNetworkManager {
    
    func request(method: NetworkMethod, url: String, params: [String: Any], _ success: @escaping SuccessHandle, _ failure: @escaping FailuerHandle)
    {
        guard let uri = URL(string: url) else { return }
        self.success = success
        self.failure = failure
        
        print("------request begin: url = \(url), \nparms = \(params), time = \(NSDate())")
        print(".")
        urlSession.dataTask(with: getRequest(method: method, url: uri, param: params)).resume()
    }
    
    
}

















