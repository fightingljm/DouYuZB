//
//  NetworkTools.swift
//  AlamofireDemo
//
//  Created by 刘金萌 on 2019/7/23.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    class func requestData(type: MethodType,URLString:String,parameters:[String:NSString]?=nil,finishedCallback:@escaping (_ result:AnyObject)->()) {
        // 1.获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        // 2.发送网络请求
        Alamofire.request(URLString,method: method,parameters: parameters).responseJSON { (response) in
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error ?? "default value")
                return
            }
            // 4.将结果回调出去
            finishedCallback(result as AnyObject)
        }
    }
}
