//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/23.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: CollectionBaseCell {
    // MARK:- 控件属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    
    // MARK:- 定义模型属性
    override var anchor:AnthorModel?{
        didSet{
            // 将属性传递给父类
            super.anchor = anchor
            // 房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }

}
