//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/8/12.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

class AmuseViewModel {
    lazy var anchorGroups:[AnthorGroup] = [AnthorGroup]()
}

extension AmuseViewModel{
    func loadAmuseData(finishedCallback:@escaping()->()) {
        NetworkTools.requestData(type: .GET, URLString: "http://open.douyucdn.cn/api/RoomApi/game") { (result) in
            
            guard let resultDict = result as? [String:NSObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else { return }
            
            for dict in dataArray{
                self.anchorGroups.append(AnthorGroup(dict: dict))
            }
            
            finishedCallback()
        }
    }
}
