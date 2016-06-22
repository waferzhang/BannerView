//
//  BannerPageControl.h
//  BannerView
//
//  Created by wafer on 16/6/21.
//  Copyright © 2016年 wafer. All rights reserved.
//

#import <UIKit/UIKit.h>

static int const pageButtonWidth = 8;

@interface BannerPageControl : UIView

- (id)initWithFrame:(CGRect)frame numCount:(int)numCount spaceX:(float)space_x;
- (void)SetBtnSelect:(int)tag;

@end
