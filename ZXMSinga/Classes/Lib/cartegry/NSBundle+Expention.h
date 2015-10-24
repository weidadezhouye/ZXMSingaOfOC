//
//  NSBundle+Expention.h
//  ZXMSinga
//
//  Created by  周学明 on 15/10/21.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (Expention)

//返回一个xib加载的路径de  view
+ (instancetype)loadViewWithNibName:(NSString*)nibName;

@end
