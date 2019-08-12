//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/22.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 10
private let kItemW = (kScreenW-3*kItemMargin)/2
private let kNormalItemH = kItemW*3/4
private let kPrettyItemH = kItemW*4/3
private let kHeaderViewH:CGFloat = 50
private let kCycleViewH = kScreenW*3/8
private let kGameViewH: CGFloat = 90

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {
    
    // MARK:- 懒加载属性
    private lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    private lazy var collectionView:UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0 // 行间距
        layout.minimumInteritemSpacing = kItemMargin // item之间的间距
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    private lazy var cycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH+kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    private lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置UI界面
        setupUI()
        
        // 发送网络请求
        loadData()
    }

}

// MARK:- 设置UI界面内容
extension RecommendViewController{
    private func setupUI(){
        // 1.将UICollectionView添加到控制器的View中
        view.addSubview(collectionView)
        // 2.将cycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        // 3.将gameView添加到UICollectionView中
        collectionView.addSubview(gameView)
        // 4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH+kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 请求数据
extension RecommendViewController{
    private func loadData(){
        // 请求推荐数据
        recommendVM.requestData {
            // 1.展示推荐数据
            self.collectionView.reloadData()
            // 2.将数据传递给GameView
            var groups = self.recommendVM.anchorGroups
            
            // 2.1.移除前两组数据
            groups.remove(at: 0)
            groups.remove(at: 0)
            // 2.2.添加更多组
            let moreGroup = AnthorGroup()
            moreGroup.game_name = "更多"
            groups.append(moreGroup)
            // groups?.insert(moreGroup, at: 0) // 为了容易调试，添加到第一个
            
            self.gameView.groups = groups
        }
        // 请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

// MARK:- 遵守UICollectionView的数据源协议
extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        // 2.定义Cell
        var cell:CollectionBaseCell!
        // 3.获取Cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
        }else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        }
        // 4.将模型赋值给cell
        cell.anchor = anchor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出setion的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        // 2.取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
