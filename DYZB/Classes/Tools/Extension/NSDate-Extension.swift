//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/24.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import Foundation

extension NSDate{
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = nowDate.timeIntervalSince1970
        return "\(interval)"
    }
}
