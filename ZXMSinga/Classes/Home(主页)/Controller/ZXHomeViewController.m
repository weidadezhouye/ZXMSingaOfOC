//
//  ZXHomeViewController.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/18.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXHomeViewController.h"
#import "ZXOneViewController.h"
#import "ZXTitleBtn.h"
#import "ZXPopController.h"

@interface ZXHomeViewController ()

@end

@implementation ZXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barBtnWithNolImgName:@"navigationbar_friendsearch" selImgName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSecrchBtnClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnWithNolImgName:@"navigationbar_pop" selImgName:@"navigationbar_pop_highlighted" target:self action:@selector(popBtnClick)];
    //self.title = @"首页";
//    为了响应首页title的点击，故而title这个位置必须放置button
//    创建button(使用自定义的)
    ZXTitleBtn *titleBtn = [ZXTitleBtn buttonWithType:UIButtonTypeCustom];
    
//    将自定义的按钮为标题位置视图赋值
    self.navigationItem.titleView = titleBtn;
//    为按钮添加点击事件
    [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}





//监听添加朋友按钮的点击事件
- (void)friendSecrchBtnClick
{
    ZXOneViewController *oneVc = [[ZXOneViewController alloc] init];
    [self.navigationController pushViewController:oneVc animated:YES];
    
    
}
//监听扫一扫按钮的点击
- (void)popBtnClick
{
    ZXOneViewController *oneVc = [[ZXOneViewController alloc] init];
    [self.navigationController pushViewController:oneVc animated:YES];
}


//今天title按钮的点击事件
- (void)titleBtnClick:(ZXTitleBtn*)btn
{
//    创建一个View
    UIView *view  = [[UIView alloc] init];
    view.bounds = CGRectMake(0, 0, 80, 120);
    view.backgroundColor = [UIColor redColor];

//    创建popController
    ZXPopController *popController = [[ZXPopController alloc] initWithView:view];
    
//    展示popController
    [popController showInView:btn];
    NSLog(@"我来了");
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
