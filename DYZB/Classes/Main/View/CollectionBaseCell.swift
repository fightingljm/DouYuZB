//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/24.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionBaseCell: UICollectionViewCell {

    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    // MARK:- 定义模型属性
    var anchor:AnthorModel?{
        didSet{
            // 校验模型是否有值
            guard let anchor = anchor else { return }
            // 1.取出在线人数显示的文字
            var onlineStr:String = ""
            if anchor.online>=10000{
                onlineStr = "\(Int(anchor.online/10000))万在线"
            }else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            // 2.昵称的显示
            nicknameLabel.text = anchor.nickname
            // 3.设置封面图片
            guard let iconURL = URL(string: anchor.room_src) else { return }
            iconImageView.kf.setImage(with: iconURL)
        }
    }
}
