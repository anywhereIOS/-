//
//  WTRegisterController.m
//  环信基本集成
//
//  Created by 王涛 on 16/4/3.
//  Copyright © 2016年 304. All rights reserved.
//

#import "WTRegisterController.h"
#import "EMSDK.h"
@interface WTRegisterController()
@property (nonatomic,strong) UITextField *nameField;
@property (nonatomic,strong) UITextField *pwdField;
@end
@implementation WTRegisterController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatRegistUser];
}
-(void)creatRegistUser
{
    UILabel *labelName = [[UILabel alloc] init];
    labelName.frame = CGRectMake(50, 114, 100, 50);
    labelName.text = @"用户名";
    labelName.font = [UIFont systemFontOfSize:13];
    [labelName setTextColor:[UIColor orangeColor]];
    [self.view addSubview:labelName];
    
    UITextField *nameField = [[UITextField alloc] init];
    nameField.placeholder = @"请输入用户名";
    nameField.frame = CGRectMake(100, 124, 150, 30);
    [nameField setBorderStyle:UITextBorderStyleRoundedRect];
    self.nameField = nameField;
    [self.view addSubview:nameField];
    
    UILabel *lablePwd = [[UILabel alloc] init];
    lablePwd.frame = CGRectMake(50, 184, 100, 50);
    lablePwd.text = @"密码";
    [lablePwd setTextColor:[UIColor orangeColor]];
    
    lablePwd.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:lablePwd];
    
    UITextField *pwdField = [[UITextField alloc] init];
    pwdField.frame = CGRectMake(100, 194, 150, 30);
    pwdField.placeholder = @"请输入密码";
    pwdField.secureTextEntry = YES;
    [pwdField setBorderStyle:UITextBorderStyleRoundedRect];
    self.pwdField = pwdField;
    [self.view addSubview:pwdField];
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registUser) forControlEvents:UIControlEventTouchUpInside];
    registBtn.frame = CGRectMake(180, 234, 50, 50);
    [registBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:registBtn];
}
-(void)registUser
{
    EMError *error;
    
    if (self.pwdField.text.length&&self.nameField.text.length) {
        error = [[EMClient sharedClient] registerWithUsername:self.nameField.text password:self.pwdField.text];
    }
    if (!error) {
        NSLog(@"注册成功");
    }
}
@end
