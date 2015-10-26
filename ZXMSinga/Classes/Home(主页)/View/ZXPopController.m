//
//  ZXPopController.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/24.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXPopController.h"

@interface ZXPopController ()

//全局保存要展示的View
@property(nonatomic,strong) UIView *view;

//定义一个imagview将写满内容的View添加上去，因为要显示的是一个有尖尖的popview
@property(nonatomic,strong) UIImageView *popView;

//定义一个全局的遮盖
@property(nonatomic,strong) UIButton *coverBtn;


@end


@implementation ZXPopController

//模仿POPView的写法给一个依赖于一个控制器的方法
- (instancetype)initWithView:(UIView *)view
{
    
    if(self = [super init])
    {
        _view = view;
//        创建popView
        self.popView = [[UIImageView alloc] init];
//        加载图片并且添加拉伸效果
//        UIImage *image = [UIImage imageNamed:@"popover_background"];
//        image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:0.5*image.size.height];
//        self.popView.image = image;
//        设置View在popVIew上面的frame
//        设置间距
        CGFloat padding = 10;
//        距离顶部的间距要稍微大一点，单独设置
        CGFloat topPadding = 15;
        CGFloat viewX = padding;
        CGFloat viewY = topPadding;
//        设置frame
        view.frame = CGRectMake(viewX, viewY, view.w, view.h);
//        将图片添加到popVIew上面
        //        设置popView的size
        CGFloat popViewW = 2*padding + view.w;
        CGFloat popViewH = padding + topPadding + view.h;
        self.popView.size = CGSizeMake(popViewW, popViewH);
//      将显示文字的View添加到popView里面
        [self.popView addSubview:self.view];
        
//        创建遮盖，初始化属性
        self.coverBtn = [[UIButton alloc] init];
        self.coverBtn.bounds = [UIScreen mainScreen].bounds;

//        为遮盖添加点击事件
        [self.coverBtn addTarget:self action:@selector(coverBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
    
}
//监听这该按钮的点击事件
- (void)coverBtnClick
{
//    将coverBtn从父控件移除
    [self.coverBtn removeFromSuperview];
//    将婆婆View移除
    [self.popView removeFromSuperview];
}


//展示View （下面有一个增强版的方法）
- (void)showInView:(UIView *)view
{
    [self showInView:view WithPosition:positionBottonCenter];
}

//展示View（在什么位置展示）
- (void)showInView:(UIView *)view WithPosition:(positionBotton )position
{
    //    获取主窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.coverBtn.x = 0;
    self.coverBtn.y = 0;
    //    为了遮住导航栏按钮，必须将遮盖添加在窗口上;
    [window addSubview:self.coverBtn];
    //    展示需要的popView
    //    设置展示的位置
    //    CGPoint Center = view.center;
    //    Center.y += self.popView.h *0.5 + view.h * 0.5;
    //    self.popView.center = Center;
    
    CGPoint viewCenterInWindow = [[view superview] convertPoint:view.center toView:nil];
    viewCenterInWindow.y += self.popView.h *0.5 + view.h * 0.5;
   
    
    //    将popView添加到传入的View的父控件里面
    [window addSubview:self.popView];
    
    if(position == positionBottonLift)
    {
//        更换图片
        self.popView.image = [UIImage resizeImgWithName:@"popover_background_left"];
//        重新设置frame
        viewCenterInWindow.x += (self.popView.w - view.w) *0.5;
        
    }else if (position == positionBottonRight)
    {
        //        更换图片
        self.popView.image = [UIImage resizeImgWithName:@"popover_background_right"];
        //        重新设置frame
        viewCenterInWindow.x -= (self.popView.w - view.w) *0.5;
    }else
    {
        //        更换图片
        self.popView.image = [UIImage resizeImgWithName:@"popover_background"];
    }
    

     self.popView.center = viewCenterInWindow;
}


//重写set方法，将传入的透明度赋值
- (void)setAlpha:(CGFloat)alpha
{
    if(alpha > 0)
    {
        [self.coverBtn setBackgroundColor:[UIColor blackColor]];
        self.coverBtn.alpha = alpha;
        
    }
}

- (void)dismiss
{
    [self coverBtnClick];
}




@end
