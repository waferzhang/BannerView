//
//  BannerView.m
//  BannerView
//
//  Created by wafer on 16/6/21.
//  Copyright © 2016年 wafer. All rights reserved.
//

#import "BannerView.h"
#import "BannerPageControl.h"
#import "bannerModel.h"
#import "UIImageView+WebCache.h"

@interface BannerView()<UIScrollViewDelegate>
{
    UIScrollView *bannerView;
    int pages;
    NSMutableArray *bannerImageArr;
    UIButton *imageButton;
    int final_page;
    BannerPageControl *pageControl;
    
    NSTimer *timer;
    int times;
}
@end

@implementation BannerView

- (BannerView *)initWithFrame:(CGRect)frame bannerModelArr:(NSMutableArray *)modelArr
{
    return [self initWithFrame:frame bannerModelArr:modelArr pageControlBtnPalce:PageControlButtonPlaceTypeNull];
}

- (BannerView *)initWithFrame:(CGRect)frame bannerModelArr:(NSMutableArray *)modelArr pageControlBtnPalce:(PageControlButtonPlaceType)pageBtnPlace
{
    return [self initWithFrame:frame bannerModelArr:modelArr pageControlBtnPalce:pageBtnPlace cutTime:0];
}

- (BannerView *)initWithFrame:(CGRect)frame bannerModelArr:(NSMutableArray *)modelArr pageControlBtnPalce:(PageControlButtonPlaceType)pageBtnPlace cutTime:(int)time
{
    self = [super initWithFrame:frame];
    if (self) {
        pages = 1;
        final_page = 1;
        bannerImageArr = modelArr;
        times = time;
        int ImageCount = (int)modelArr.count;
        
        bannerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        bannerView.showsVerticalScrollIndicator = NO;
        bannerView.showsHorizontalScrollIndicator = NO;
        bannerView.canCancelContentTouches = NO;
        bannerView.contentSize = CGSizeMake(self.frame.size.width * ImageCount, self.frame.size.height);
        bannerView.pagingEnabled = YES;
        bannerView.delegate = self;
        
        //图片点击事件
        imageButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * ImageCount, self.frame.size.height)];
        imageButton.backgroundColor = [UIColor clearColor];
        
        [imageButton addTarget:self action:@selector(imageClick) forControlEvents:UIControlEventTouchUpInside];
        [bannerView addSubview:imageButton];
        
        //定时器，每隔几秒运行一次某个方法
        if (time > 0) {
            
            // 取数组最后一张图片 放在第0页
            UIImageView *imageView = [[UIImageView alloc] init];
            BannerModel *firstPage = [modelArr objectAtIndex:([modelArr count] - 1)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:firstPage.carousel_url] placeholderImage:nil];
            imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height); // 添加最后1页在首页 循环
            [bannerView addSubview:imageView];
            // 取数组第一张图片 放在最后1页
            imageView = [[UIImageView alloc] init];
            BannerModel *lastPage = [modelArr objectAtIndex:0];
            [imageView sd_setImageWithURL:[NSURL URLWithString:lastPage.carousel_url] placeholderImage:nil];
            imageView.frame = CGRectMake((self.frame.size.width * ([modelArr count] + 1)), 0, self.frame.size.width, self.frame.size.height); // 添加第1页在最后 循环
            [bannerView addSubview:imageView];
            
            [bannerView setContentSize:CGSizeMake(self.frame.size.width * ([modelArr count] + 2), self.frame.size.height)];
            
            
            timer = [NSTimer scheduledTimerWithTimeInterval:time
                                                     target:self
                                                   selector:@selector(imageViewScroll)
                                                   userInfo:nil
                                                    repeats:YES];
            [bannerView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
            
        }
        else {
            [bannerView scrollRectToVisible:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) animated:NO];
            
        }
        
        switch (pageBtnPlace) {//pagecontrol的位置
            case PageControlButtonPlaceTypeLeft:
            {
                pageControl = [[BannerPageControl alloc] initWithFrame:CGRectMake(pageButtonWidth, self.frame.size.height - 3*pageButtonWidth, ImageCount * pageButtonWidth*1.5, pageButtonWidth*3) numCount:ImageCount spaceX:pageButtonWidth*1.5];
                [self addBannerImageViewWithArr:modelArr spaceX:2*self.frame.size.width/3 labelFlag:YES];
               break;
            }
            case PageControlButtonPlaceTypeRight:
            {
                pageControl = [[BannerPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width -ImageCount*pageButtonWidth*1.5, self.frame.size.height - 3*pageButtonWidth, modelArr.count*pageButtonWidth*1.5, pageButtonWidth*3) numCount:(int)modelArr.count spaceX:pageButtonWidth*1.5];
                [self addBannerImageViewWithArr:modelArr spaceX:pageButtonWidth labelFlag:YES];
                break;
            }
            case PageControlButtonPlaceTypeCenter:
            {
                pageControl = [[BannerPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - ImageCount*pageButtonWidth/2, self.frame.size.height - 3*pageButtonWidth, ImageCount * pageButtonWidth*1.5, pageButtonWidth*3) numCount:(int)modelArr.count spaceX:pageButtonWidth*1.5];
                [self addBannerImageViewWithArr:modelArr spaceX:0 labelFlag:NO];
                break;
            }
            case PageControlButtonPlaceTypeNull:
            {
                [self addBannerImageViewWithArr:modelArr spaceX:0 labelFlag:NO];
                pageControl.hidden = YES;
                break;
            }

        }
        
        pageControl.clipsToBounds = YES;
        
        [self addSubview:bannerView];
        [self addSubview:pageControl];
    }

    return self;

}

/*
    添加bannerview与pagecontrol 根据pagecontrol的位置决定标题的位置
 */
- (void)addBannerImageViewWithArr:(NSMutableArray *)arr spaceX:(int)spaceX labelFlag:(BOOL)flag
{
    for (int i = 0; i < arr.count; i++) {
        BannerModel *bannerModel = [arr objectAtIndex:i];
        UIImageView *bannerImageView = [[UIImageView alloc] init];
        [bannerImageView sd_setImageWithURL:[NSURL URLWithString:bannerModel.carousel_url] placeholderImage:nil];
        if (times > 0) {
            bannerImageView.frame = CGRectMake(i * self.frame.size.width + self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        }else{
            bannerImageView.frame = CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        }
        if (flag) {
            //渐变色
            UIImageView *layerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 88, self.frame.size.width, 88)];
            [layerView setImage:[UIImage imageNamed:@"banner_bottom"]];
            //标题
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(spaceX, layerView.frame.size.height - pageButtonWidth*3, self.frame.size.width/3, pageButtonWidth*3)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.font = [UIFont systemFontOfSize:14];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.text = bannerModel.title;
            [layerView addSubview:titleLabel];
            [bannerImageView addSubview:layerView];
        }
        
        [bannerView addSubview:bannerImageView];
    }
}


//定时器自动滑动图片
- (void)imageViewScroll
{
    if (pages > [bannerImageArr count] + 1) {
        return;
    }
    pages++;
    
    if (pages == [bannerImageArr count] + 1) {
        [bannerView scrollRectToVisible:CGRectMake(self.frame.size.width * pages, 0, self.frame.size.width, self.frame.size.height) animated:YES]; // 最后+1,循环第1页
        
        [pageControl SetBtnSelect:pages - 1];
        final_page = pages;
    }
    else {
        [bannerView setContentOffset:CGPointMake(pages * self.frame.size.width, 0) animated:YES]; // 最后+1,循环第1页
        
        [pageControl SetBtnSelect:pages - 1];
        final_page = pages;
    }
}

//手动拖拽图片
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //关闭定时器
    if (times > 0) {
        [timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (pages == [bannerImageArr count] + 1 && times > 0) {
        pages = 1;
        
        [bannerView scrollRectToVisible:CGRectMake(self.frame.size.width * pages, 0, self.frame.size.width, self.frame.size.height) animated:NO]; // 最后+1,循环第1页
        [pageControl SetBtnSelect:pages - 1];
        final_page = pages;
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //定时器，每隔几秒运行一次某个方法
    if (times > 0) {
        
        timer = [NSTimer scheduledTimerWithTimeInterval:times
                                                 target:self
                                               selector:@selector(imageViewScroll)
                                               userInfo:nil
                                                repeats:YES];
    }
}

// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x / self.frame.size.width + .1);
    
    if (times > 0) {
        if (pages != page) {
            [pageControl SetBtnSelect:page - 1];
            final_page = page;
            pages = page;
        }
        if (page == ([bannerImageArr count] + 1)) {
            [scrollView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO]; // 最后+1,循环第1页
            page = 1;
            [pageControl SetBtnSelect:page - 1];
            final_page = page;
            pages = page;
        }
        else if (page == 0) {
            [scrollView scrollRectToVisible:CGRectMake(self.frame.size.width * [bannerImageArr count], 0, self.frame.size.width, self.frame.size.height) animated:NO]; // 最后+1,循环第1页
            page = (int)bannerImageArr.count;
            [pageControl SetBtnSelect:page - 1];
            final_page = page;
            pages = page;
        }
    }
    else {
        [pageControl SetBtnSelect:page];
    }
}

//图片点击事件
- (void)imageClick
{
    BannerModel *clickBanner = [bannerImageArr objectAtIndex:final_page - 1];
    //点击按钮时，调用委托方法，委托它的父类来执行方法
    [self.bannerViewClickDelegate bannerViewTouchWithModel:clickBanner];
}


@end
