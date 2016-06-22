//
//  BannerPageControl.m
//  BannerView
//
//  Created by wafer on 16/6/21.
//  Copyright © 2016年 wafer. All rights reserved.
//

#import "BannerPageControl.h"

@interface BannerPageControl()
{
    UIButton *pageBtn;
    int numCount;
}

@end

@implementation BannerPageControl

- (id)initWithFrame:(CGRect)frame numCount:(int)num spaceX:(float)space_x
{
    self = [super initWithFrame:frame];
    if (self) {
        numCount = num;
        
        UIImageView *iPageBtnNormal = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PageControl_Normal.png"]];
        float PageBtnWidth = iPageBtnNormal.frame.size.width;
        for (int i = 0; i < num; i++) {
            pageBtn = [[UIButton alloc] initWithFrame:CGRectMake(i * space_x, (self.frame.size.height - PageBtnWidth) / 2 + 1, pageButtonWidth, pageButtonWidth)];
            [pageBtn setImage:[UIImage imageNamed:@"PageControl_Normal.png"] forState:UIControlStateNormal];
            pageBtn.tag = 1001 + i;
            pageBtn.enabled = NO;
            
            [self addSubview:pageBtn];
        }
        [self SetBtnSelect:0];
    }
    return self;
}

- (void)SetAllBtnBackGroundImg
{
    for (int i = 0; i < numCount; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:1001 + i];
        [btn setImage:[UIImage imageNamed:@"PageControl_Normal.png"] forState:UIControlStateNormal];
    }
}

- (void)SetBtnSelect:(int)tag
{
    if (tag > numCount) {
    }
    else {
        [self SetAllBtnBackGroundImg];
        UIButton *btn = (UIButton *)[self viewWithTag:1001 + tag];
        [btn setImage:[UIImage imageNamed:@"PageControl_Select.png"] forState:UIControlStateNormal];
    }
}


@end
