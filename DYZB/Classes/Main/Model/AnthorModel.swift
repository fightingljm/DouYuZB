//
//  AnthorModel.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/24.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

class AnthorModel: NSObject {
    // 房间ID
    @objc var room_id:Int = 0
    // 房间图片url
    @objc var room_src:String = ""
    // 判断是手机直播还是电脑直播
    // 0-电脑直播 1-手机直播
    @objc var isVertical:Int = 0
    // 房间名称
    @objc var room_name:String = ""
    // 主播昵称
    @objc var nickname:String = ""
    // 观看人数
    @objc var online:Int = 0
    // 所在城市
    @objc var anchor_city:String = "天津市"
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
