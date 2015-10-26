//
//  AppDelegate.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/18.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建窗口。自己加载
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //创建跟控制器
    UITabBarController *tab = [[UITabBarController alloc] init];
    //为跟控制器添加导航控制器
    for(int i =0;i<4;i++)
    {
        //创建导航控制器的视图控制器
        UIViewController *Vc = [[UIViewController alloc] init];
        //创建导航控制器
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:Vc];
        //设置导航控制器的tabBarItem的名称
        nav.tabBarItem.title = @"ooo";
        //添加自控制器
        [tab addChildViewController:nav];
        
    }
    
    window.rootViewController = tab;
    //显示
    [window makeKeyAndVisible];
    self.window = window;
    
    return YES;
}


@end
