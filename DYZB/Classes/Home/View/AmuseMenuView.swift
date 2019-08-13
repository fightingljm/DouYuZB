//
//  AmuseMenuView.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/8/13.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

class AmuseMenuView: UIView {

}

extension AmuseMenuView {
    class func amuseMenuView()->AmuseMenuView{
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}
