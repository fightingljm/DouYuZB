
//
//  CycleModel.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/25.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    // 标题
    var room_name:String = ""
    // 展示的图片地址
    var room_src:String = ""
    // 主播信息对应的字典
    var room:[String:NSObject]?{
        didSet{
            guard let room = room else { return }
            anchor = AnthorModel(dict: room)
        }
    }
    // 主播信息对应的模型对象
    var anchor:AnthorModel?
    // MARK:- 自定义构造函数
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
