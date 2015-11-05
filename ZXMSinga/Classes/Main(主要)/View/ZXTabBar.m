//
//  ZXTabBar.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/24.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXTabBar.h"


@interface ZXTabBar ()

@property(nonatomic,weak)UIButton *plusBtn;


@end

@implementation ZXTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
//        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_background_os7"]];
//       只需要设置中间的加号按钮即可
        [self setupPlusBtn];
    }
    return self;
}

//创建中间加号按钮的方法
- (void)setupPlusBtn
{
//    创建按钮
    UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    设置背景
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
//    设置image
    [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
//    写死加号按钮的大小
    plusBtn.size = CGSizeMake(64, 44);
    
    [plusBtn addTarget:self action:@selector(plusBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    //    添加
    [self addSubview:plusBtn];
//    赋值
    self.plusBtn = plusBtn;
}

- (void)plusBtnClick:(UIButton *)plusBtn{
    if([self.delegate respondsToSelector:@selector(tabBar:plusBtn:)])
    {
        [self.delegate tabBar:self plusBtn:plusBtn];
    }
}

//布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
//  设置加号按钮的中心
    CGFloat centerX = self.w *0.5;
    CGFloat centerY = self.h *0.5;
    self.plusBtn.center  = CGPointMake(centerX, centerY);
//    计算按钮的个数应该等于系统自带的按钮个数加上一个加号按钮
    NSInteger itemCount = self.items.count +1;
    CGFloat itemW = self.w / itemCount;
    CGFloat itemH = self.h;
    NSInteger index = 0;
//    重新布局所有按钮的位置
    for (UIView *item in self.subviews) {
        if([item isKindOfClass:NSClassFromString(@"UITabBarButton" )])  //????????
        {
           
            if(index > 1)
            {
              item.frame = CGRectMake(itemW * (index+ 1), 0, itemW, itemH);
            }else
            {
                 item.frame = CGRectMake(index * itemW, 0, itemW, itemH);
            }
//            设置字体的颜色
            [self setupTitleColorWithView:item index:index];
            index ++;
        }
        
    }
    
}

//设置颜色
- (void)setupTitleColorWithView:(UIView *)view index:(NSInteger)index
{
    NSInteger selectedIndex = [self.items indexOfObject:self.selectedItem];
    for(id selectedBtn in view.subviews)
    {
        if([selectedBtn isKindOfClass:[UILabel class]])
        {
            UILabel *label = selectedBtn;
            
           if(selectedIndex ==index)
           {
               label.textColor = [UIColor orangeColor];
           }else
           {
               label.textColor = [UIColor grayColor];
           }
            
        }
    }
}













@end
