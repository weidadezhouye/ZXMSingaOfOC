//
//  ZXTabBarController.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/18.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXTabBarController.h"
#import "ZXMeViewController.h"
#import "ZXHomeViewController.h"
#import "ZXMessageViewController.h"
#import "ZXDiscoverViewController.h"
#import "ZXNavigationController.h"
#import "ZXTabBar.h"
#import "ZXComposeController.h"
#import "ZXAccout.h"
#import "ZXOAuthController.h"

@interface ZXTabBarController ()<ZXTabBarDelegate>

@end

@implementation ZXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //为跟控制器添加导航控制器
//    for(int i =0;i<4;i++)
//    {
//        //创建导航控制器的视图控制器
//        UIViewController *Vc = [[UIViewController alloc] init];
//        //创建导航控制器
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:Vc];
//        //设置导航控制器的tabBarItem的名称
//        nav.tabBarItem.title = @"ooo";
//        //添加自控制器
//        [self addChildViewController:nav];
//        
//    }
    ZXTabBar *tabbar = [[ZXTabBar alloc] init];
//    设置代理
    tabbar.delegate = self;
    
    
#warning 当碰到私有属性不能转化的时候，可以使用kvc的方式设置
    [self setValue:tabbar forKey:@"tabBar"];
    
    [self addChildTabBarItems];
   
    
}

//添加底部的按钮
- (void)addChildTabBarItems
{
    ZXHomeViewController *homeVc = [[ZXHomeViewController alloc] init];
    [self addChildVc:homeVc title:@"主页" nolImageName:@"tabbar_home" selImageName:@"tabbar_home_selected"];
    
    ZXMessageViewController *messageVc = [[ZXMessageViewController alloc] init];
    [self addChildVc:messageVc title:@"消息" nolImageName:@"tabbar_message_center" selImageName:@"tabbar_message_center_selected"];
    
    ZXDiscoverViewController *discoverVc = [[ZXDiscoverViewController alloc] init];
    [self addChildVc:discoverVc title:@"发现" nolImageName:@"tabbar_discover" selImageName:@"tabbar_discover_selected"];
    
    ZXMeViewController *meVc = [[ZXMeViewController alloc] init];
    [self addChildVc:meVc title:@"我" nolImageName:@"tabbar_profile" selImageName:@"tabbar_profile_selected"];
    
}


//为导航添加子控制器
- (void)addChildVc:(UITableViewController *)vc title:(NSString *)title
      nolImageName:(NSString *)nolImageName selImageName:(NSString *)selImageName
{
    ZXNavigationController *nav = [[ZXNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    
    nav.tabBarItem.image = [UIImage imageNamed:nolImageName];
    
    UIImage *img = [UIImage imageNamed:selImageName];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    nav.tabBarItem.selectedImage = img;
    
    [self addChildViewController:nav];
    
}

//这个方法不调用的话就会在切换的时候看不到橙色的字体颜色
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [tabBar layoutSubviews];
}

#pragma mark - ZXTabBarDelegate代理方法的实现
- (void)tabBar:(ZXTabBar *)tabBar plusBtn:(UIButton *)plusBtn
{
//    创建
    ZXAccout * accout = [ZXAccout shareAccout];
    ZXOAuthController * oaVc = [[ZXOAuthController alloc] init];
    ZXComposeController *cmpVc = [[ZXComposeController alloc] init];
//    判断是否登录
    if(accout.isLogin)
    {//如果已经登录，就进入发说说的控制器
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cmpVc];
        [self presentViewController:nav animated:YES completion:nil];
    }else
    {
        [UIApplication sharedApplication].keyWindow.rootViewController = oaVc;
    }
    
    
}

@end
