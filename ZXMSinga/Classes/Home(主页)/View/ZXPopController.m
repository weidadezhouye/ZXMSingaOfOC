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
        UIImage *image = [UIImage imageNamed:@"popover_background"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:0.5*image.size.height];
        self.popView.image = image;
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
        
    }
    return self;
    
}

//展示View
- (void)showInView:(UIView *)view
{
//    展示需要的popView
//    设置展示的位置
    CGPoint Center = view.center;
    Center.y += self.popView.h *0.5 + view.h * 0.5;
    self.popView.center = Center;
    
//    将popView添加到传入的View的父控件里面
    [[view superview] addSubview:self.popView];
    
    
    
}



@end
