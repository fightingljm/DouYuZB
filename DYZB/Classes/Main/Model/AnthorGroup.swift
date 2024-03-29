//
//  AnthorGroup.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/24.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

class AnthorGroup: BaseGameModel {
    // 该组中对应的房间信息
    @objc var room_list:[[String:NSObject]]? {
        didSet{
            guard let room_list = room_list else { return }
            for dict in room_list{
                anchors.append(AnthorModel(dict: dict))
            }
        }
    }
    // 组显示的标题
    @objc var tag_name:String = ""
    // 组显示的图标
    @objc var icon_name:String = "home_header_normal"
    // 定义主播的模型对象数组
    lazy var anchors:[AnthorModel] = [AnthorModel]()
}
