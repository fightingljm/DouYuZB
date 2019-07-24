//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/24.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

class RecommendViewModel {
    // MARK:- 懒加载属性
    private lazy var anchorGroups:[AnthorGroup] = [AnthorGroup]()
}

// "http://capi.douyucdn.cn/api/v1/getHotCate"
// "http://capi.douyucdn.cn/api/v1/getVerticalRoom"
// "http://capi.douyucdn.cn/api/v1/getHotCate"

// MARK:- 发送网络请求
extension RecommendViewModel{
    func requestData(){
        // 1.请求推荐数据
        
        // 2.请求颜值数据
        
        // 3.请求游戏数据
        NetworkTools.requestData(type: .GET, URLString: "http://open.douyucdn.cn/api/RoomApi/live", parameters: ["limit" : "4","offset": "4"]) { (result) in
            print("###########")
            print(result)
            print("###########")
            // 1.将result转成字典类型
            guard let resultDic = result as? [String:NSObject] else { return }
            // 2.根据data该key,获取数组
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else { return }
            // 3.遍历数组，获取字典，并且将字典转成模型对象
            for dict in dataArray{
                let group = AnthorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            for group in self.anchorGroups{
                print("--------------")
                print(group.tag_name)
                print("--------------")
                for anthor in group.anchors{
                    print("@@@@@@@@@@@@@@")
                    print(anthor.nickname)
                    print("@@@@@@@@@@@@@@")
                    
                }
            }
        }
    }
}
