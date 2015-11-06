//
//  ZXStatusBar.m
//  ZXMSinga
//
//  Created by  周学明 on 15/11/6.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXStatusBar.h"

//全局顶一个statusBar（下面哟一个线程 dispatch_after）
static ZXStatusBar * statusBar;

@implementation ZXStatusBar

//创建就会进入这个方法
- (instancetype)init
{
    if(self = [super initWithFrame:[UIApplication sharedApplication].statusBarFrame])
    {
#warning  加上一定的距离才能使得我们创建的window在状态栏的上面
        self.windowLevel = UIWindowLevelStatusBar + 5;
        
    }
    return self;
}

//添加文字并且设置出现和消失
+ (void)showStatusBarWith:(NSString *)title
{
    statusBar = [[ZXStatusBar alloc] init];
//    创建View
    UIView *statusView = [[UIView alloc] init];
    statusView.backgroundColor = [UIColor orangeColor];
//    设置statusView的大小和statusbar的大小一致
    statusView.frame = statusBar.bounds;
    
//    在View上添加一个label，显示内容
    UILabel *lab = [[UILabel alloc] init];
//    设置label的属性
    lab.text = title;
    lab.textColor = [UIColor whiteColor];
    lab.frame = statusView.bounds;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.transform = CGAffineTransformMakeTranslation(0, 20);
#warning 一定要裁剪，否则超出显示界面
    lab.clipsToBounds = YES;
    lab.font = [UIFont systemFontOfSize:13];
    [statusView addSubview:lab];
//    添加到statusView上面
    [statusBar addSubview:statusView];
//    设置动画时间
    CGFloat duration = 1;
//    创建动画，改变label的transform实现显示和消失
    [UIView animateWithDuration:duration animations:^{
        lab.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
//        一段时间之后让它消失，并且将statusBar赋值为空
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:duration animations:^{
                lab.transform = CGAffineTransformMakeTranslation(0, -20);
            } completion:^(BOOL finished) {
                statusBar = nil;
            }];
        });
    }];
#warning 窗口显示必须调用这个方法
    [statusBar makeKeyAndVisible];
    
    
    
    
    
}


@end
