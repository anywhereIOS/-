//
//  ViewController.m
//  环信基本集成
//
//  Created by 王涛 on 16/4/2.
//  Copyright © 2016年 304. All rights reserved.
//

#import "ViewController.h"
#import "WTNavigation.h"
#import "WTRegisterController.h"
#import "WTLoginController.h"
#import "EMSDK.h"
#import "EMClient.h"
#import "UserModel.h"
@interface ViewController ()<EMClientDelegate>
/**
 *  名字
 */
@property (nonatomic,strong) UITextField *nameField;
/**
 *  密码
 */
@property (nonatomic,strong) UITextField *pwdField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatUser];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
    UserModel *model = mySelf;
    self.nameField.text = model.userId;
    self.pwdField.text = model.hxPasswd;

}
-(void)creatUser
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
    
    UIButton *btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLogin setTitle:@"登陆" forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    btnLogin.frame = CGRectMake(80, 234, 50, 50);
    [btnLogin setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:btnLogin];
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registUser) forControlEvents:UIControlEventTouchUpInside];
    registBtn.frame = CGRectMake(180, 234, 50, 50);
    [registBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:registBtn];
    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutBtn setTitle:@"退出" forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    logoutBtn.frame = CGRectMake(240, 234, 50, 50);
    [logoutBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:logoutBtn];
    
}
-(void)logout
{
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        NSLog(@"退出成功");
    }
}
/*
 *  当前登录账号在其它设备登录时会接收到该回调
 */
-(void)didLoginFromOtherDevice
{
    
}
/*
 *  当前登录账号已经被从服务器端删除时会收到该回调
 */
-(void)didRemovedFromServer
{
    NSLog(@"服务器已经删除账号");
}
-(void)registUser
{
    WTRegisterController *regist = [[WTRegisterController alloc] init];
    [self.navigationController pushViewController:regist animated:nil];
}
-(void)login
{
    EMError *error;
    if (self.nameField.text.length&&self.pwdField.text.length) {
    error = [[EMClient sharedClient] loginWithUsername:self.nameField.text password:self.pwdField.text];
        
        UserModel *model = mySelf;
        model.userId = self.nameField.text;
        model.hxPasswd = self.pwdField.text;
        [UserModel saveMySelf];
        
    }
    if (!error) {
        
        //设置自动登陆
        [[EMClient sharedClient].options setIsAutoLogin:YES];
        //获取数据库中的数据
        [[EMClient sharedClient].chatManager loadAllConversationsFromDB];
        //设置推送消息时的昵称
        [[EMClient sharedClient] setApnsNickname:self.nameField.text];
    
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginStateChange" object:@(YES)];
        
        WTLoginController *login = [[WTLoginController alloc] init];
        [self.navigationController pushViewController:login animated:nil];

        
        NSLog(@"登陆成功");
    }else{
        NSLog(@"请检查密码和账号");
    }
    
}
#pragma mark - EMClientDelegate

/**
 *  重新连接
 *
 *  @param aConnectionState 状态
 */
-(void)didConnectionStateChanged:(EMConnectionState)aConnectionState
{
    if (aConnectionState == EMConnectionConnected) {
        NSLog(@"正在连接");
    }else{
        NSLog(@"未连接");
    }
}
/**
 *  自动登陆后的调用
 *
 *  @param aError 返回的结果
 */
-(void)didAutoLoginWithError:(EMError *)aError
{
    NSLog(@"%@",aError);
}
@end
