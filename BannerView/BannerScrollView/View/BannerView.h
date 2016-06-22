//
//  BannerView.h
//  BannerView
//
//  Created by wafer on 16/6/21.
//  Copyright © 2016年 wafer. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSUInteger, PageControlButtonPlaceType) {
    /** pageControl位于左侧 */
    PageControlButtonPlaceTypeLeft = 0,
    /** pageControl位于中间 */
    PageControlButtonPlaceTypeCenter = 1 << 0,
    /** pageControl位于右侧 */
    PageControlButtonPlaceTypeRight = 2 << 1,
    /** pageControl隐藏 */
    PageControlButtonPlaceTypeNull = 3 << 2,
};

@protocol BannerViewClickDelegate <NSObject>

- (void)bannerViewTouchWithModel:(id)model;

@end

@interface BannerView : UIView

@property (nonatomic,assign) id<BannerViewClickDelegate> bannerViewClickDelegate;

- (BannerView *)initWithFrame:(CGRect)frame bannerModelArr:(NSMutableArray *)modelArr;

- (BannerView *)initWithFrame:(CGRect)frame bannerModelArr:(NSMutableArray *)modelArr pageControlBtnPalce:(PageControlButtonPlaceType)pageBtnPlace;

- (BannerView *)initWithFrame:(CGRect)frame bannerModelArr:(NSMutableArray *)modelArr pageControlBtnPalce:(PageControlButtonPlaceType)pageBtnPlace cutTime:(int)time;
@end
