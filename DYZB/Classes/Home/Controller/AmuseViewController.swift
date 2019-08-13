//
//  AmuseViewController.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/8/12.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()

}

// MARK:- 设置UI界面
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 请求数据
extension AmuseViewController{
    override func loadData(){
        
        // 1.给父类中ViewModel进行赋值
        baseVM = amuseVM
        
        // 2.请求数据
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}

