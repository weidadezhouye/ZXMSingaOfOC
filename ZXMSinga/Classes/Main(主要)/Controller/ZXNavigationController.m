//
//  ZXNavigationController.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/19.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXNavigationController.h"

@interface ZXNavigationController ()

@end

@implementation ZXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    获得全局的导航条
    UINavigationBar *navBar = [UINavigationBar appearance];
//    设置导航条的背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background_os7"] forBarMetrics:UIBarMetricsDefault];
//  创建阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowOffset:CGSizeMake(5, -5)];
    shadow.shadowColor = [UIColor blackColor];
//    设置全局导航栏字体的属性
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor grayColor],NSShadowAttributeName:shadow}];
    
}

//导航控制器跳转到下一个控制器的时候会调用下面的方法：
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    NSInteger childViews =  self.viewControllers.count;
    
    if(childViews==1)
    {
        UIViewController *priVc = self.viewControllers[0];
        //如果是第一页的话就显示主页的名字
        NSString *backTitle = priVc.title;
//        添加左侧的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backBtnWithTitle:backTitle target:self action:@selector(backPrivBtn)];
        
        
    }
    //说明是第二页或者是第二页以后的页面
    if(childViews > 1)
    {
        //这样创建的返回按钮没有返回的那个箭头，所以要自定义
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backPrivBtn)];
//        使用自定义的创建返回按钮的方式
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backBtnWithTitle:@"返回" target:self action:@selector(backPrivBtn)];
        
    }
    if(childViews > 0)
    {
        //添加返回主页的按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnWithNolImgName:@"navigationbar_more" selImgName:@"navigationbar_more_highlighted" target:self action:@selector(backHomeBtn)];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
}
//监听返回主页的按钮的点击事件
- (void)backHomeBtn
{
    //返回主页（一进去的第一页）
    [self popToRootViewControllerAnimated:YES];
}

//监听返回上一页按钮的点击事件：
- (void)backPrivBtn
{
    //返回上一页
    [self popViewControllerAnimated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
