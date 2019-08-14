//
//  BaseViewModel.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/8/13.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups:[AnthorGroup] = [AnthorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(isGroupData:Bool, URLString:String, parameters:[String:NSString]?=nil, finishedCallback:@escaping()->()) {
        NetworkTools.requestData(type: .GET, URLString: URLString, parameters: parameters) { (result) in
            
            guard let resultDict = result as? [String:NSObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else { return }
            
            if isGroupData {
                for dict in dataArray{
                    self.anchorGroups.append(AnthorGroup(dict: dict))
                }
            } else {
                let group = AnthorGroup()
                
                for dict in dataArray{
                    group.anchors.append(AnthorModel(dict: dict))
                }
                
                self.anchorGroups.append(group)
            }
            
            finishedCallback()
        }
    }
}
