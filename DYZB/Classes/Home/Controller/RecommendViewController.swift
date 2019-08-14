//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/22.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

private let kCycleViewH = kScreenW*3/8
private let kGameViewH: CGFloat = 90

class RecommendViewController: BaseAnchorViewController {
    
    // MARK:- 懒加载属性
    private lazy var recommendVM: RecommendViewModel = RecommendViewModel()
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

}

// MARK:- 设置UI界面内容
extension RecommendViewController{
    override func setupUI(){
        // 1.
        super.setupUI()
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
    override func loadData(){
        // 给父类中的ViewModel进行赋值
        baseVM = recommendVM
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
            
            // 请求数据完成
            self.loadDataFinished()
        }
        // 请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

// MARK:- 遵守UICollectionView的数据源协议
extension RecommendViewController: UICollectionViewDelegateFlowLayout{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            // 1.取出PrettyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
            // 2.设置数据
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell
        }else {
            return super.collectionView(collectionView,cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}
