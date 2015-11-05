//
//  ZXFooterView.m
//  ZXMSinga
//
//  Created by  周学明 on 15/11/4.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXFooterView.h"

@interface ZXFooterView ()

@property (weak, nonatomic) IBOutlet UILabel *moreLabel;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *fresh;

@end

@implementation ZXFooterView

+ (instancetype)footerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZXFooterView" owner:nil options:nil] lastObject];
    
    
}

//
- (void)setLoading:(BOOL)loading
{
    _loading = loading;
  if (loading)
  {
      self.moreLabel.hidden = YES;
      self.fresh.hidesWhenStopped = NO;
      [self.fresh startAnimating];
  }else
  {
      self.moreLabel.hidden = NO;
      self.fresh.hidesWhenStopped = YES;
      [self.fresh stopAnimating];
  }
    
}




@end
