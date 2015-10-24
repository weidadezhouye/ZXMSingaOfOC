//
//  ZXDiscoverViewController.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/18.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXDiscoverViewController.h"
#import "ZXSearchView.h"


@interface ZXDiscoverViewController ()

@end

@implementation ZXDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    这是系统自带的创建搜索框的方法，但是满足不了我们的需求
//    self.navigationItem.titleView = [[UISearchBar alloc] init];
//    使用自定义的方式去创建
    ZXSearchView *searchView = [ZXSearchView searchBarInit];
    self.navigationItem.titleView = searchView;
//    重新设置searchBar的bounds
    CGFloat searchBarW = [UIScreen mainScreen].bounds.size.width-20;
    CGRect secrchBar = searchView.bounds;
    secrchBar.size.width = searchBarW;
    searchView.bounds = secrchBar;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}



@end
