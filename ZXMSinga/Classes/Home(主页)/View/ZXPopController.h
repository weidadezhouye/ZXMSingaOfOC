//
//  ZXPopController.h
//  ZXMSinga
//
//  Created by  周学明 on 15/10/24.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXPopController : NSObject


//模仿POPView的写法给一个依赖于一个控制器的方法
- (instancetype)initWithView:(UIView *)view;



//展示View
- (void)showInView:(UIView *)view;

@end
