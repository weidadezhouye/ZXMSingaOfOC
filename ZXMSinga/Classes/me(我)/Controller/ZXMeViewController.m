//
//  ZXMeViewController.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/18.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXMeViewController.h"
//#import "UIBarButtonItem+Expention.h"
#import "ZXOneViewController.h"

@interface ZXMeViewController ()

@end

@implementation ZXMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *title = @"设置";
//    
//    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
//    CGSize titleSize =  [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]} context:nil].size; //16？？？？？
//    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    
//    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    
//    //设置禁用状态下的按钮的状态
//    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
//    
//    btn.frame = CGRectMake(0, 0, titleSize.width, titleSize.height);
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnWithTitle:title target:self action:@selector(settingBtnClick)];
    
}

//监听设置按钮的点击事件
- (void)settingBtnClick
{
    
    ZXOneViewController *oneVc = [[ZXOneViewController alloc] init];
    [self.navigationController pushViewController:oneVc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
