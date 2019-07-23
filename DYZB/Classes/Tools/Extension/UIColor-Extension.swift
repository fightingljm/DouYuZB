//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/19.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0,green:g/255.0,blue:b/255.0,alpha:1.0)
    }
}
