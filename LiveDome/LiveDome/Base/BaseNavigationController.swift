//
//  BaseNavigationController.swift
//  NewDerivative
//
//  Created by zbwx on 2017/12/19.
//  Copyright © 2017年 zbwx. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //self.automaticallyAdjustsScrollViewInsets = true;
        // Do any additional setup after loading the view.
        //self.extendedLayoutIncludesOpaqueBars = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //二级页面隐藏tabbar
        if !viewController.isKind(of: FocusViewController.self)
            && !viewController.isKind(of: RecommendViewController.self)
        && !viewController.isKind(of: PushStremViewController.self){
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
}
