//
//  ZXTabBar.h
//  ZXMSinga
//
//  Created by  周学明 on 15/10/24.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXTabBar;

@protocol ZXTabBarDelegate <NSObject>

- (void)tabBar:(ZXTabBar *)tabBar plusBtn:(UIButton *)plusBtn;

@end


@interface ZXTabBar : UITabBar

@property(nonatomic,weak)id<ZXTabBarDelegate> delegate;

@end
