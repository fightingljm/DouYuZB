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
    lazy var anchorGroups:[AnthorGroup] = [AnthorGroup]()
    lazy var cycleModels:[CycleModel] = [CycleModel]()
    private lazy var bigData:AnthorGroup = AnthorGroup()
    private lazy var prettyData:AnthorGroup = AnthorGroup()
}

// "http://capi.douyucdn.cn/api/v1/getHotCate"
// "http://capi.douyucdn.cn/api/v1/getVerticalRoom"
// "http://capi.douyucdn.cn/api/v1/getHotCate"

// MARK:- 发送网络请求
extension RecommendViewModel{
    // 请求推荐数据
    func requestData(finishCallback:@escaping ()->()){
        // 定义参数
        let parameters:[String : NSString] = ["limit" : "4","offset": "0"]
        // 创建group
        let dGroup = DispatchGroup()
        // 1.请求推荐数据
        dGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://open.douyucdn.cn/api/RoomApi/live", parameters: parameters) { (result) in
            // 1.将result转成字典类型
            guard let resultDic = result as? [String:NSObject] else { return }
            // 2.根据data该key,获取数组
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else { return }
            // 3.遍历数组，获取字典，并且将字典转成模型对象
            // 3.1 创建组
            // let group = AnthorGroup()
            // 3.2 设置组的属性
            self.bigData.tag_name = "热门"
            self.bigData.icon_name = "home_header_hot"
            // 3.3 获取主播数据
            for dict in dataArray{
                let anchor = AnthorModel(dict: dict)
                self.bigData.anchors.append(anchor)
            }
            // 离开组
            dGroup.leave()
        }
        // 2.请求颜值数据
        dGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://open.douyucdn.cn/api/RoomApi/live", parameters: parameters) { (result) in
            // 1.将result转成字典类型
            guard let resultDic = result as? [String:NSObject] else { return }
            // 2.根据data该key,获取数组
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else { return }
            // 3.遍历数组，获取字典，并且将字典转成模型对象
            // 3.1 创建组
            // let group = AnthorGroup()
            // 3.2 设置组的属性
            self.prettyData.tag_name = "颜值"
            self.prettyData.icon_name = "home_header_phone"
            // 3.3 获取主播数据
            for dict in dataArray{
                let anchor = AnthorModel(dict: dict)
                self.prettyData.anchors.append(anchor)
            }
            // 离开组
            dGroup.leave()
        }
        // 3.请求游戏数据
        dGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://open.douyucdn.cn/api/RoomApi/live", parameters: parameters) { (result) in
            // 1.将result转成字典类型
            guard let resultDic = result as? [String:NSObject] else { return }
            // 2.根据data该key,获取数组
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else { return }
            // 3.遍历数组，获取字典，并且将字典转成模型对象
            for dict in dataArray{
                let group = AnthorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            // 离开组
            dGroup.leave()
        }
        
        // 所有的数据都请求到之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyData, at: 0)
            self.anchorGroups.insert(self.bigData, at: 0)
            finishCallback()
        }
    }
    // 请求无限轮播的数据
    func requestCycleData(finishCallback:@escaping ()->()) {
        NetworkTools.requestData(type: .GET, URLString: "http://open.douyucdn.cn/api/RoomApi/live/1",parameters: ["limit":"4"]) { (result) in
            // 1.将result转成字典类型
            guard let resultDic = result as? [String:NSObject] else { return }
            // 2.根据data该key,获取数组
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else { return }
            for dict in dataArray{
                self.cycleModels.append(CycleModel(dict: dict))
            }
            finishCallback()
        }
    }
}
