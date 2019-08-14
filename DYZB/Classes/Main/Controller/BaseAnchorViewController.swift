//
//  BaseAnchorViewController.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/8/13.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 10
private let kHeaderViewH:CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

let kPrettyCellID = "kPrettyCellID"
let kNormalItemW = (kScreenW-3*kItemMargin)/2
let kNormalItemH = kNormalItemW*3/4
let kPrettyItemH = kNormalItemW*4/3

class BaseAnchorViewController: BaseViewController {

    // MARK:- 定义属性
    var baseVM:BaseViewModel!
    lazy var collectionView:UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
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
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI() 
        loadData()
    }

}

// MARK:- 设置UI界面
extension BaseAnchorViewController {
    override func setupUI() {
        contentView = collectionView
        
        view.addSubview(collectionView)
        
        super.setupUI()
    }
}

// MARK:- 请求数据
extension BaseAnchorViewController{
    @objc func loadData(){
        
    }
}

// MARK:- 遵守UICollectionView的数据源
extension BaseAnchorViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        // 2.给Cell设置数据
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.给HeaderView设置数据
        headerView.group = baseVM.anchorGroups[indexPath.section]
        
        return headerView
    }
}

// MARK:- 遵守UICollectionView的代理协议
extension BaseAnchorViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        anchor.isVertical == 0 ? pushNormalRoomVc() : presentShowRoomVc()
    }
    
    private func presentShowRoomVc() {
        let showRoomVc = RoomShowViewController()
        
        present(showRoomVc, animated: true, completion: nil)
    }
    
    private func pushNormalRoomVc() {
        let normalRoomVc = RoomNormalViewController()
        
        navigationController?.pushViewController(normalRoomVc, animated: true)
    }
}
