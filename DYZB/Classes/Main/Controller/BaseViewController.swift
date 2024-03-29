//
//  BaseViewController.swift
//  DYZB
//
//  Created by 刘金萌 on 2019/8/14.
//  Copyright © 2019 刘金萌. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK:- 定义属性
    var contentView : UIView?

    // MARK:- 懒加载属性
    fileprivate lazy var animImageView : UIImageView = {[unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

extension BaseViewController {
    @objc func setupUI() {
        
        contentView?.isHidden = true
        
        view.addSubview(animImageView)
        
        animImageView.startAnimating()
        
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    @objc func loadDataFinished(){
        
        animImageView.stopAnimating()
        
        animImageView.isHidden = true
        
        contentView?.isHidden = false
    }
}
