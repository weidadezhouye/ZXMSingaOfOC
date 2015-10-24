//
//  ZXOneViewController.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/19.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXOneViewController.h"
#import "ZXTwoViewController.h"

@interface ZXOneViewController ()

@end

@implementation ZXOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"one";
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ZXTwoViewController *vc = [[ZXTwoViewController alloc] init];
    
    //1、modal出来的界面（不能直接返回）
    //[self.navigationController presentViewController:vc animated:YES completion:nil];
    //2、推送出去的界面（可以直接返回）
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
