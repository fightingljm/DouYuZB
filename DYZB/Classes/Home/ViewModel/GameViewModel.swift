//
//  GameViewModel.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/8/12.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games:[GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadAllGameData(finishedCallback:@escaping()->()) {
        
        let parameters:[String : NSString] = ["limit" : "4","offset": "0"]
        
        NetworkTools.requestData(type: .GET, URLString: "http://open.douyucdn.cn/api/RoomApi/game", parameters: parameters) { (result) in
            //1.获取到数据
            guard let resultDict = result as? [String:Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else { return }
            
            //2.字典转模型
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            
            //3.完成回调
            finishedCallback()
        }
    }
}
