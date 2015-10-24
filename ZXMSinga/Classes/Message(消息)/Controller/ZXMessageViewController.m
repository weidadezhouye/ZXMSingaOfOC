//
//  ZXMessageViewController.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/18.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXMessageViewController.h"
#import "ZXOneViewController.h"

@interface ZXMessageViewController ()

@end

@implementation ZXMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = @"发起聊天";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnWithTitle:title target:self action:@selector(askTackBtnClick)];
    //设置禁用状态
    //self.navigationItem.rightBarButtonItem.enabled = NO;
    
    }

//监听发起聊天按钮的点击事件
- (void)askTackBtnClick
{
    ZXOneViewController *oneVc = [[ZXOneViewController alloc] init];
    [self.navigationController pushViewController:oneVc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}


@end
