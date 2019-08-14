//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/8/12.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {
    
}

extension AmuseViewModel{
    func loadAmuseData(finishedCallback:@escaping()->()) {
        loadAnchorData(isGroupData: true, URLString: "http://open.douyucdn.cn/api/RoomApi/game", finishedCallback: finishedCallback)
    }
}
