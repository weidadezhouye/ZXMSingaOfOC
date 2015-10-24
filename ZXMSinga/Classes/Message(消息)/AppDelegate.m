//
//  AppDelegate.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/18.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "AppDelegate.h"
#import "ZXTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建窗口。自己加载
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //创建跟控制器
    ZXTabBarController *tab = [[ZXTabBarController alloc] init];
    
    //[NSThread sleepForTimeInterval:2];
    window.rootViewController = tab;
    //显示
    [window makeKeyAndVisible];
    self.window = window;
    
    return YES;
}


@end
