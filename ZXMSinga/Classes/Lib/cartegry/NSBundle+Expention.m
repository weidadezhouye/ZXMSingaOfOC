//
//  NSBundle+Expention.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/21.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "NSBundle+Expention.h"

@implementation NSBundle (Expention)

//返回一个xib加载的路径的view
+ (id)loadViewWithNibName:(NSString*)nibName
{
    return [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil].lastObject;
}

@end
