//
//  ZXEnterView.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/25.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXEnterView.h"
#import "ZXTabBarController.h"

@implementation ZXEnterView


+ (instancetype)enterView
{
    return [NSBundle loadViewWithNibName:@"ZXEnterView"];
}

// 监听分享给朋友按钮的点击事件
- (IBAction)share:(UIButton *)sender {
//    更改选中状态
    sender.selected = ! sender.selected;
    
}


//监听进入博客按钮的点击事件
- (IBAction)enterBlog {
//    保存当前的版本号到沙盒
    [NSUserDefaults saveCurrentVersion];
    
    ZXTabBarController *tabBarColVc = [[ZXTabBarController alloc] init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarColVc;
    
}

@end
