//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/23.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    
    // MARK:- 控件属性
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK:- 定义模型属性
    var group: AnthorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
}
