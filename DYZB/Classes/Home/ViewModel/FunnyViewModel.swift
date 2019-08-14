//
//  FunnyViewModel.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/8/14.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel {
    func loadFunnyData(finishedCallback: @escaping()->()) {
        loadAnchorData(isGroupData: false, URLString: "http://open.douyucdn.cn/api/RoomApi/live/4", finishedCallback: finishedCallback)
    }
}
