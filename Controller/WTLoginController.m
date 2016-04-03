//
//  WTLoginController.m
//  环信基本集成
//
//  Created by 王涛 on 16/4/3.
//  Copyright © 2016年 304. All rights reserved.
//

#import "WTLoginController.h"
//#import "EaseUI.h"
#import "UserModel.h"
@implementation WTLoginController
-(void)viewDidLoad
{
    [super viewDidLoad];
    UserModel *model = mySelf;
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"单聊" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    btn.frame = CGRectMake(100, 100, 50, 50);
    [btn addTarget: self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}
-(void)btnClick
{
    
    
}
@end
