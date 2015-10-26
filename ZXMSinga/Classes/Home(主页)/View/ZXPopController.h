//
//  ZXPopController.h
//  ZXMSinga
//
//  Created by  周学明 on 15/10/24.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
   positionBottonLift,
    positionBottonCenter,
    positionBottonRight,
} positionBotton;


@interface ZXPopController : NSObject


//模仿POPView的写法给一个依赖于一个控制器的方法
- (instancetype)initWithView:(UIView *)view;



//展示View
- (void)showInView:(UIView *)view;

//从外界传入一个设置透明度的属性
@property(nonatomic,assign) CGFloat alpha;


- (void)dismiss;


//展示View（在什么位置展示）
- (void)showInView:(UIView *)view WithPosition:(positionBotton )position;

@end
