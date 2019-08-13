//
//  AmuseViewController.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/8/12.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

class AmuseViewController: BaseAnchorViewController {

    // MARK:- 懒加载属性
    private lazy var amuseVM : AmuseViewModel = AmuseViewModel()

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

