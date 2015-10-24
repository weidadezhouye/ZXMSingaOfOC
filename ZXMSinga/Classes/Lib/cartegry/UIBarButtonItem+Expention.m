//
//  UIBarButtonItem+Expention.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/18.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "UIBarButtonItem+Expention.h"

@implementation UIBarButtonItem (Expention)

+ (instancetype)barBtnWithNolImgName:(NSString *)nolImgName selImgName:(NSString *)selImgName target:(id)target action:(SEL)action
{
    //UIButton *btn = [[UIButton alloc] init];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置背景图片
    [btn setBackgroundImage:[UIImage imageNamed:nolImgName] forState:UIControlStateNormal];
    
    [btn setBackgroundImage:[UIImage imageNamed:selImgName] forState:UIControlStateHighlighted];
    //添加事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //根据图片大小设置按钮的frame
    UIImage *img = [UIImage imageNamed:nolImgName];
    
    
    btn.frame = CGRectMake(0, 0, img.size.width, img.size.height);//???
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn]; //?????
    

}


//自定义导航栏按钮的样式
+ (instancetype)barBtnWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);//????
    CGSize titleSize =  [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]} context:nil].size; //16？？？？？
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    //设置禁用状态下的按钮的状态
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    btn.frame = CGRectMake(0, 0, titleSize.width, titleSize.height);
    //按钮添加事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

//自定义导航控制器的左边返回按钮
+ (instancetype)backBtnWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
//    获取常规图片
    UIImage *nolImage = [UIImage imageNamed:@"navigationbar_back_withtext"];
//    获取高亮状态下的图片
    UIImage *selImage = [UIImage imageNamed:@"navigationbar_back_withtext_highlighted"];
//    设置字体的宽度跟随字体的大小变化而变化
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGSize titleSize = [title boundingRectWithSize:size options:0 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;

    //创建按钮
    UIButton *btn = [[UIButton alloc] init];
    //设置按钮的image
    [btn setImage:nolImage forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateHighlighted];
//    设置按钮的文字
    [btn setTitle:title forState:UIControlStateNormal];
//    设置常规状态下的字体颜色
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    设置高亮状态下字体颜色
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
//    设置图片和文字的间隔
    CGFloat pading = 5;
//    根据image和title的大小确定按钮的frame
    btn.frame = CGRectMake(0, 0, nolImage.size.width+pading+titleSize.width, nolImage.size.height);
//    为按钮添加点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

@end
