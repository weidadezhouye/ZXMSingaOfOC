//
//  ZXToolBar.h
//  ZXMSinga
//
//  Created by  周学明 on 15/11/5.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXToolBar;


typedef  enum
{
    toolBarBtnTypePic,  //图片
    toolBarBtnTypeMetion,//@
    toolBarBtnTypeThred,//#
    toolBarBtnTypeeMoticon,//表情
    toolBarBtnTypeAdd//添加
}toolBarBtnType;

@protocol ZXToolBarDelegate <NSObject>


- (void)toolBar:(ZXToolBar *)toolBar btnType:(toolBarBtnType)btnType;

@end


@interface ZXToolBar : UIView

@property(nonatomic,weak)id<ZXToolBarDelegate> delegate;



@end
