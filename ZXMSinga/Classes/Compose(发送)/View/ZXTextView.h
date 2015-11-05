//
//  ZXTextView.h
//  ZXMSinga
//
//  Created by  周学明 on 15/11/5.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXTextView : UITextView

//占位内容
@property(nonatomic,copy) NSString *placeHolder;

//占位字体颜色
@property(nonatomic,strong) UIColor *placeHolderColor;


@end
