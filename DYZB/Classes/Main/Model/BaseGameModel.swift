//
//  BaseGameModel.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/8/12.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    // 组显示的标题
    @objc var game_name:String = ""
    // 组显示的图标
    @objc var game_icon:String = "home_header_normal"
    
    // MARK:- 自定义构造函数
    override init() {
        
    }
    init(dict:[String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        // print("BaseGameModel-forUndefinedKey",key)
    }
}
