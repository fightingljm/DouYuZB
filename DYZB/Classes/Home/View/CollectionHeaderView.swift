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
            
            let game_icon = group?.game_icon ?? "home_header_normal"
            guard let iconURL = URL(string: game_icon) else { return }
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: game_icon))
        }
    }
    
}

// MARK:- 从xib中快速创建的类方法
extension CollectionHeaderView {
    class func collectionHeaderView()->CollectionHeaderView{
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
