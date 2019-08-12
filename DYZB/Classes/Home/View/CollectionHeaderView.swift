//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/23.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionHeaderView: UICollectionReusableView {
    
    
    // MARK:- 控件属性
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    
    // MARK:- 定义模型属性
    var group: AnthorGroup?{
        didSet{
            titleLabel.text = group?.game_name
            guard let iconURL = URL(string: group?.game_icon ?? "home_header_normal") else { return }
            iconImageView.kf.setImage(with: iconURL)
//            iconImageView.image = UIImage(named: group?.game_icon ?? "home_header_normal")
        }
    }
    
}
