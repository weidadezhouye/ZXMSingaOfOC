//
//  ZXNewFeatureController.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/25.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXNewFeatureController.h"
#import "ZXEnterView.h"


@interface ZXNewFeatureController ()<UIScrollViewDelegate>

@property(nonatomic,strong) UIPageControl *pageCol;


@end

@implementation ZXNewFeatureController



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    创建轮播控制器
    UIScrollView * scrollView = [[UIScrollView alloc] init];
//    设置代理
    scrollView.delegate = self;
//    设置frame
    scrollView.frame = self.view.bounds;
//    设置分页效果
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
//    设置图片的宽高
    CGFloat imageY = 0;
    CGFloat imageH = scrollView.h;
    CGFloat imageW = scrollView.w;
//    添加图片
    for (int i = 1; i < 5; i++) {
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(imageW * (i-1), imageY, imageW, imageH);
        [scrollView addSubview:imageView];
        
//        如果是最后一页的话就添加按钮的xib
        if(i ==4)
        {
            ZXEnterView *enterView = [ZXEnterView enterView];
            CGPoint center = self.view.center;
            center.y += 100;
            enterView.center = center;
            imageView.userInteractionEnabled = YES;
            [imageView addSubview:enterView];
        }
        
    
    }
    scrollView.contentSize = CGSizeMake(imageW * 4, 0);
    
    
    
//    添加到View上面
    [self.view addSubview:scrollView];
    
//    创建分页控制器
    UIPageControl * pageCol = [[UIPageControl alloc] init];
//    设置页数
    pageCol.numberOfPages = 4;
//    设置当前页数的颜色
    pageCol.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    pageCol.pageIndicatorTintColor = [UIColor grayColor];
//    pageCol.backgroundColor = [UIColor grayColor];
//    设置与底部的间距
    CGFloat bottonH = 60;
//    设置frame
    CGFloat pageColX = 0;
    CGFloat pageColH = 20;
    CGFloat pageColW = scrollView.w;
    CGFloat pageColY = scrollView.h - bottonH - pageColH;
    pageCol.frame = CGRectMake(pageColX, pageColY, pageColW, pageColH);
//    添加到视图上
    [self.view addSubview:pageCol];
//    赋值
    self.pageCol = pageCol;
    
    
    
}


#pragma mark - UIScrollViewDelegate 代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    偏移值达到一半的时候就开始改变当前页
    CGFloat page = (scrollView.contentOffset.x + scrollView.w * 0.5) / scrollView.w;
    
    self.pageCol.currentPage = page;
}



@end
