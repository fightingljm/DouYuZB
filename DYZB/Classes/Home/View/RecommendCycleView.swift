//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/24.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    // MARK:- 定义属性
    var cycleModels:[CycleModel]?{
        didSet{
            // 刷新collectionView
            collectionView.reloadData()
            // 设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }
    
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    // MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()
        // 注册Cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置collectionView的layout
        let layoyt = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layoyt.itemSize = collectionView.bounds.size
    }
}

// MARK:- 提供一个快速创建View的类方法
extension RecommendCycleView{
    class func recommendCycleView()->RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView",owner: nil,options:nil)?.first as! RecommendCycleView
    }
}

// MARK:- 遵守UICollectionView的数据源协议
extension RecommendCycleView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModels![indexPath.item]
        
        return cell
    }
    
}

// MARK:- 遵守UICollectionView的代理协议
extension RecommendCycleView:UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width*0.5
        // 2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX/scrollView.bounds.width)
    }
}
