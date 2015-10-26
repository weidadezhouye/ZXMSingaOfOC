//
//  AppDelegate.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/18.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "AppDelegate.h"
#import "ZXTabBarController.h"
#import "ZXNewFeatureController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建窗口。自己加载
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //创建跟控制器
//    ZXTabBarController *tab = [[ZXTabBarController alloc] init];
    
    //[NSThread sleepForTimeInterval:2];
//    window.rootViewController = tab;
    
//    获取版本号：
    NSString *currentVersion = [NSUserDefaults versionFromInfo];
//    获取沙盒里面保存的版本
    NSString *versionInShaBox = [NSUserDefaults versionFromShaBox];
    if(versionInShaBox ==nil || [currentVersion doubleValue] != [versionInShaBox doubleValue])
    {
        //    创建新特性界面
        ZXNewFeatureController *newFeature = [[ZXNewFeatureController alloc] init];
        window.rootViewController = newFeature;

    }else
    {
//        进入主控制器
        ZXTabBarController *tabVc = [[ZXTabBarController alloc] init];
        window.rootViewController = tabVc;
    }
    
    
    //显示
    [window makeKeyAndVisible];
    self.window = window;
    
    return YES;
}


@end
