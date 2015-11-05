//
//  ZXTextView.m
//  ZXMSinga
//
//  Created by  周学明 on 15/11/5.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXTextView.h"

@interface ZXTextView ()

//占位的文本框
@property(nonatomic,strong) UILabel *placeHoderLabel;


@end


@implementation ZXTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UILabel * label = [[UILabel alloc] init];
        [self addSubview:label];
        self.placeHoderLabel = label;
        self.placeHoderLabel.numberOfLines = 0;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}





//监听值的改变
- (void)textChange
{
    self.placeHoderLabel.hidden = self.text.length > 0;
}


#pragma mark - 属性值的设置
- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    self.placeHoderLabel.text = placeHolder;
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;
    self.placeHoderLabel.textColor = placeHolderColor;
    
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeHoderLabel.font = font;
}


//布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    计算宽高
    CGFloat labelW = self.w - 5* 2;
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = self.placeHoderLabel.font;
    CGSize placeHolderSize = [self.placeHolder boundingRectWithSize:CGSizeMake(labelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil].size;
    self.placeHoderLabel.frame = CGRectMake(5, 7, labelW, placeHolderSize.height);
    
    
    
    
}

//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
