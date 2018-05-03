//
//  PushStremViewController.m
//  LiveDome
//
//  Created by zbwx on 2018/5/3.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "PushStremViewController.h"

@interface PushStremViewController ()
@property(nonatomic,strong)UITextField *nameText;
@end

@implementation PushStremViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:YBNameImage(@"bg_zbfx")];
    
    [self setupName];
}
- (void)setupName{
    self.nameText = [[UITextField alloc] init];
    self.nameText.backgroundColor = [UIColor colorWithPatternImage:YBNameImage(@"global_background")];
    [self.nameText setPlaceholder:@"设置房间名"];
    [self.nameText setTextColor:[UIColor whiteColor]];
    [self.view addSubview:self.nameText];
    [self.nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(SCREEN_WIDTH/5);
        make.top.mas_equalTo(self.view).offset(100);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(SCREEN_HEIGHT/4);
    }];
    __weak typeof(self) tempSelf = self;
    UIButton * startBtn = [UIButton buttonWithTitle:@"开始直播" font:YBSystemFont(15) titleColor:[UIColor whiteColor] withBlock:^(id sender) {
        [tempSelf playInputClick];
    }];
    [self.view addSubview:startBtn];
    [startBtn setBackgroundColor:[UIColor colorWithPatternImage:YBNameImage(@"room_button")]];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(SCREEN_WIDTH/5);
        make.top.mas_equalTo(self.nameText.mas_bottom).offset(100);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(250);
    }];
}
-(void)playInputClick{
    StartViewController *vc =[[StartViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
