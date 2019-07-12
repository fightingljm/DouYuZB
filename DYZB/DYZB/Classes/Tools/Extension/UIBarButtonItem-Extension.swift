//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/7/12.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    /*
     // 类函数 UIBarButtonItem.createItem
    class func createItem(imageName:String,hightImageName:String,size:CGSize)->UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGSize.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    */
    
    // 便利构造函数：1> convenience开头。2> 在构造函数中必须明确调用一个设计的构造函数
    convenience init(imageName:String,hightImageName:String="",size:CGSize=CGSize.zero) {
        // 1.创建UIButton
        let btn = UIButton()
        // 2.设置btn的图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if hightImageName != ""{
            btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        }
        // 3.设置btn的尺寸
        if(size==CGSize.zero){
            btn.sizeToFit()
        }else{
             btn.frame = CGRect(origin: CGPoint(), size: size)
        }
        // 4.创建UIBarButtonItem
        self.init(customView: btn)
    }
}
