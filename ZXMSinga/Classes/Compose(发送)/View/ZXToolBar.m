//
//  ZXToolBar.m
//  ZXMSinga
//
//  Created by  周学明 on 15/11/5.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXToolBar.h"

@implementation ZXToolBar


- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
//        设置背景
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]]];
        [self setupToolBar];
        
    }
    
    return self;
    
}

//设置工具条（5个按钮）
- (void)setupToolBar{
    // 图片选择
    [self addBtnWithNmlImg:@"compose_toolbar_picture" hltImg:@"compose_toolbar_picture_highlighted"];
    
    // @
    [self addBtnWithNmlImg:@"compose_mentionbutton_background" hltImg:@"compose_mentionbutton_background_highlighted"];
    
    //#
    [self addBtnWithNmlImg:@"compose_trendbutton_background" hltImg:@"compose_trendbutton_background_highlighted"];
    
    //表情
    [self addBtnWithNmlImg:@"compose_emoticonbutton_background" hltImg:@"compose_emoticonbutton_background_highlighted"];
    
    [self addBtnWithNmlImg:@"compose_addbutton_background" hltImg:@"compose_addbutton_background_highlighted"];
    

    
    
    
    
}

//创建按钮
- (void)addBtnWithNmlImg:(NSString *)nolImgName hltImg:(NSString *)hgtImgName{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:nolImgName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hgtImgName] forState:UIControlStateHighlighted];
    [self addSubview:btn];

}


//布局子控件
- (void)layoutSubviews
{
    
    [super layoutSubviews];
    CGFloat width = self.w / self.subviews.count;
    CGFloat height = 44;
    NSInteger index = 0;
    
    for(UIButton *btn in self.subviews)
    {
        btn.frame = CGRectMake(index * width, 0, width, height);
        index ++;
        
    }
}


@end
