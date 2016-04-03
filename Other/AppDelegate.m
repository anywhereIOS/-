//
//  AppDelegate.m
//  环信集成
//
//  Created by 王涛 on 16/4/3.
//  Copyright © 2016年 304. All rights reserved.
//

#import "AppDelegate.h"
#import "EMSDK.h"
#import "WTNavigation.h"
#import "ViewController.h"
//#import "EaseUI.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *vc = [[ViewController alloc] init];
    WTNavigation *nav = [[WTNavigation alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:@"loginStateChange"
                                               object:nil];
    
//    [[EaseSDKHelper shareHelper] easemobApplication:application didFinishLaunchingWithOptions:launchOptions appkey:@"taolove41#huanxinjibenjicheng" apnsCertName:nil otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    EMOptions *options = [EMOptions optionsWithAppkey:@"taolove41#huanxinjibenjicheng"];
    options.apnsCertName  = @"";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    return YES;
}
-(void)loginStateChange:(NSNotification *)notification
{
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    BOOL loginSucess = [notification.object boolValue];
    if (isAutoLogin || loginSucess) {
        NSLog(@"自动登陆");
    }else{
        NSLog(@"没有设置自动登陆");
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
