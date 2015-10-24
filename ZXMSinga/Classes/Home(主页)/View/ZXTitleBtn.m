//
//  ZXTitleBtn.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/21.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXTitleBtn.h"
#define image [UIImage imageNamed:@"new_dot"]
#define imageWidth 10

@implementation ZXTitleBtn


//只要使用了init，就一定会来到这个方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setTitle:@"风亦有情" forState:UIControlStateNormal];
//        设置image
        [self setImage:image forState:UIControlStateNormal];
//        设置背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_line"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"] forState:UIControlStateHighlighted];
//        设置frame
        self.frame = CGRectMake(0, 0, 100, 44);
//        设置title的颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        设置title的字体大小
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:18];
//        设置字体居中显示
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
#warning  代码设置图片的圆角
        self.layer.cornerRadius =5;
        self.layer.masksToBounds = YES;
    }
    return self;
}

//在布局子控件的方法里重新布局image和title的位置
- (void)layoutSubviews
{
//    调用父类
    [super layoutSubviews];
//    计算image的frame
    //    设置间距
    CGFloat pading = 5;
//    获得文字的size
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    self.w = titleSize.width + pading +imageWidth;
    self.h = titleSize.height + 4;
//    获得图片的宽高
    CGFloat imageW = imageWidth;
    CGFloat imageH = self.h;
    CGFloat imageX = self.w - imageW;
    CGFloat imageY = 0;
//    设置图片的frame
    self.imageView.frame = CGRectMake(imageX,imageY,imageW,imageH);
//    计算title的宽高
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = self.w - imageW - pading;
    CGFloat titleH = self.h;
//    设置title的frame
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);

}

@end
