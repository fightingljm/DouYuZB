//
//  RecommendGameView.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/25.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin:CGFloat = 10

class RecommendGameView: UIView {
    // MARK:- 定义数据属性
    var groups:[AnthorGroup]?{
        didSet{
            // 1.移除前两组数据
            groups?.remove(at: 0)
            groups?.remove(at: 0)
            // 2.添加更多组
            let moreGroup = AnthorGroup()
            moreGroup.game_name = "更多"
            groups?.append(moreGroup)
            // groups?.insert(moreGroup, at: 0) // 为了容易调试，添加到第一个
            // 3.刷新表格
            collectionView.reloadData()
        }
    }
    
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()
        
        // 注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        // 给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
}

// MARK:- 提供快速创建的类方法
extension RecommendGameView{
    class func recommendGameView()->RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

// MARK:- 遵守UIcollectionView的数据源协议
extension RecommendGameView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.group = groups![indexPath.item]
        
        return cell
    }
    
    
}
