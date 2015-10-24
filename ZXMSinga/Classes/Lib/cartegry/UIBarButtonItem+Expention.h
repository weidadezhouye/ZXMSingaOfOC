//
//  UIBarButtonItem+Expention.h
//  ZXMSinga
//
//  Created by  周学明 on 15/10/18.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Expention)
//返回一个带有普通图片和选中状态的图片的按钮样式
+ (instancetype)barBtnWithNolImgName:(NSString *)nolImgName selImgName:(NSString *)selImgName target:(id)target action:(SEL)action;

//自定义导航栏带有文字的按钮的样式
+ (instancetype)barBtnWithTitle:(NSString *)title target:(id)target action:(SEL)action;


//自定义导航控制器的左边返回按钮
+ (instancetype)backBtnWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
