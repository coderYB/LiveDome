//
//  BaseViewController.m
//  LiveDome
//
//  Created by zbwx on 2018/5/2.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
@interface BaseViewController ()

@end

@implementation BaseViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSUserDefaults standardUserDefaults] setObject:NSStringFromClass(self.class) forKey:@"CURRENT_VIEWCONTROLLER"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [APP_DELEGATE setCurrentViewController:self];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CURRENT_VIEWCONTROLLER"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [APP_DELEGATE setCurrentViewController:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHex:0x333333],NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName, nil];
    self.navigationController.navigationBar.translucent = false;
    self.automaticallyAdjustsScrollViewInsets = YES;
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [_backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_backButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_backButton setNormalImageName:@"nav_back_button"];
    [_backButton setHighlightedImageName:@"nav_back_button"];
    [_backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    if ([self.navigationController.viewControllers count] > 1 || self.tabBarController == nil) {
        [self.navigationItem setLeftBarButtonItem:_backBarButtonItem];
    }
    
    
    
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
}

/**
 *  返回事件
 *
 *  @param touchButton <#touchButton description#>
 */
-(void)backAction:(UIButton*)touchButton{
    if (self.navigationController && [self.navigationController.viewControllers count] == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setPageTrueName:(NSString *)pageTrueName {
    _pageTrueName = pageTrueName;
    
    if (_pageTrueName) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        titleLabel.text = _pageTrueName;
        titleLabel.font = [UIFont systemFontOfSize: 17];
        titleLabel.textColor = [UIColor colorWithHex: 0x333333];
        [titleLabel sizeToFit];
        self.navigationItem.titleView = titleLabel;
    }
    
}

-(void)dealloc {
    
    NSLog(@"%@~~delloc",NSStringFromClass([self class]));
}

@end
