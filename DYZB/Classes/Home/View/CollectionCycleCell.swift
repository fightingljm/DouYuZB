//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/25.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // MARK:- 定义模型属性
    var cycleModel:CycleModel?{
        didSet{
            titleLabel.text = cycleModel?.room_name
            let url = URL(string: cycleModel?.room_src ?? "https://rpic.douyucdn.cn/asrpic/190725/288016_0952.png/dy1")
            iconImageView.kf.setImage(with: url)
        }
    }

}
