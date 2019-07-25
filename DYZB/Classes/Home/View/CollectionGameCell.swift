//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/25.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    
    // MARK:- 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK:- 定义模型属性
    var group: AnthorGroup?{
        didSet{
            titleLabel.text = group?.game_name
            guard let iconURL = URL(string: group?.game_icon ?? "home_header_normal") else { return }
            iconImageView.kf.setImage(with: iconURL,placeholder: UIImage(named: "home_more_btn"))
        }
    }

}
