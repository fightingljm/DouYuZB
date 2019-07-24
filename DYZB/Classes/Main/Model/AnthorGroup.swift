//
//  AnthorGroup.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/24.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

class AnthorGroup: NSObject {
    // 该组中对应的房间信息
    var room_list:[[String:NSObject]]? {
        didSet{
            guard let room_list = room_list else { return }
            for dict in room_list{
                anchors.append(AnthorModel(dict: dict))
            }
        }
    }
    // 组显示的标题
    var tag_name:String = ""
    // 组显示的图标
    var icon_name:String = "home_header_normal"
    // 定义主播的模型对象数组
    lazy var anchors:[AnthorModel] = [AnthorModel]()
    
    // MARK:- 构造函数
    override init() {
        
    }
    
    init(dict:[String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
