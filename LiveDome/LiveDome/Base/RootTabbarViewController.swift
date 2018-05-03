//
//  RootTabbarViewController.swift
//  NewDerivative
//
//  Created by zbwx on 2017/12/19.
//  Copyright © 2017年 zbwx. All rights reserved.
//

import UIKit

class RootTabbarViewController: UITabBarController,UITabBarControllerDelegate {

    var focusNavigationController:BaseNavigationController!
    var recommendNavigationController:BaseNavigationController!
    var pushStremNavigationController:BaseNavigationController!
    
    
    var focusViewController:FocusViewController!
    var recommendViewController:RecommendViewController!
    var pushStremViewController:PushStremViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.recommendViewController = RecommendViewController()
        self.recommendViewController.title = "推荐"
        self.recommendNavigationController = BaseNavigationController(rootViewController: self.recommendViewController)
        
        
        self.focusViewController = FocusViewController()
        self.focusViewController.title = "关注"
        self.focusNavigationController = BaseNavigationController(rootViewController: self.focusViewController)
        
        self.pushStremViewController = PushStremViewController()
        self.pushStremViewController.title = "直播"
        self.pushStremNavigationController = BaseNavigationController(rootViewController: self.pushStremViewController)
        self.reloadTabbarItem()
        // Do any additional setup after loading the view.
    }
    
    //重新加载tabbar
    func reloadTabbarItem(){
        
        
        let viewControllers:NSMutableArray = [self.recommendNavigationController,self.focusNavigationController,self.pushStremNavigationController]

        self.setViewControllers(viewControllers as? [UIViewController], animated: true)
        for  index in 0...(self.tabBar.items?.count)!-1 {
            let item:UITabBarItem = self.tabBar.items![index]
            
            item.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.lightGray,NSFontAttributeName:UIFont.systemFont(ofSize: 10)], for: UIControlState())
            
            item.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.red,NSFontAttributeName:UIFont.systemFont(ofSize: 10)], for: UIControlState.selected)
            item.tag = index;
            
            switch index {
            case 0:
                item.image = UIImage(named:"tab_live")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
                item.selectedImage = UIImage(named:"tab_live_p")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
                item.title = "推荐"
            case 1:
                item.image = UIImage(named:"tab_live")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
                item.selectedImage = UIImage(named:"tab_live_p")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
                item.title = "关注"
            case 2:
                item.image = UIImage(named: "tab_live")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
                item.selectedImage = UIImage(named: "tab_live_p")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
                item.title = "直播"
            default:
                break
            }
        
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
