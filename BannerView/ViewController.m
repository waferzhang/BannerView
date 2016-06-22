//
//  ViewController.m
//  BannerView
//
//  Created by wafer on 16/6/21.
//  Copyright © 2016年 wafer. All rights reserved.
//

#import "ViewController.h"
#import "BannerView.h"
#import "BannerModel.h"

@interface ViewController ()<BannerViewClickDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"轮播"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(addBannerView)];
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"引导"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(addLeadView)];

}

//轮播图例子
- (void)addBannerView
{
    BannerModel *mm1 = [[BannerModel alloc] init];
    mm1.title = @"sdfafsasdfa";
    mm1.carousel_url = @"http://img1.3lian.com/2015/w7/98/d/22.jpg";
    BannerModel *mm2 = [[BannerModel alloc] init];
    mm2.title = @"sdfafsasdfa";
    mm2.carousel_url = @"http://pic1.nipic.com/2008-12-09/200812910493588_2.jpg";
    BannerModel *mm3 = [[BannerModel alloc] init];
    mm3.title = @"sdfafsasdfa";
    mm3.carousel_url = @"http://pic9.nipic.com/20100904/4845745_195609329636_2.jpg";


    NSMutableArray *adfa = [NSMutableArray array];
    [adfa addObject:mm1];
    [adfa addObject:mm2];
    [adfa addObject:mm3];

    BannerView *banger1 = [[BannerView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200) bannerModelArr:adfa pageControlBtnPalce:PageControlButtonPlaceTypeLeft cutTime:3];
    BannerView *banger2 = [[BannerView alloc] initWithFrame:CGRectMake(0, 420, self.view.frame.size.width, 200) bannerModelArr:adfa pageControlBtnPalce:PageControlButtonPlaceTypeRight cutTime:3];
    banger1.bannerViewClickDelegate = self;
    banger2.bannerViewClickDelegate = self;
    [self.view addSubview:banger1];
    [self.view addSubview:banger2];

    
}

//引导页例子------可以有pagecontrol也可以没有pagecontrol
- (void)addLeadView
{
    BannerModel *mm1 = [[BannerModel alloc] init];
    mm1.carousel_url = @"http://img1.3lian.com/2015/w7/98/d/22.jpg";
    BannerModel *mm2 = [[BannerModel alloc] init];
    mm2.carousel_url = @"http://pic1.nipic.com/2008-12-09/200812910493588_2.jpg";
    BannerModel *mm3 = [[BannerModel alloc] init];
    mm3.carousel_url = @"http://pic9.nipic.com/20100904/4845745_195609329636_2.jpg";
    BannerModel *mm4 = [[BannerModel alloc] init];
    mm4.carousel_url = @"http://img.taopic.com/uploads/allimg/140714/234975-140G4155Z571.jpg";
    
    NSMutableArray *adfa = [NSMutableArray array];
    [adfa addObject:mm1];
    [adfa addObject:mm2];
    [adfa addObject:mm3];
    [adfa addObject:mm4];

    //不显示pagecontrol
    BannerView *banger = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) bannerModelArr:adfa];
    
    //显示pagecontrol
//    BannerView *banger = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) bannerModelArr:adfa pageControlBtnPalce:PageControlButtonPlaceTypeCenter];
    banger.bannerViewClickDelegate = self;
    
    [self.view addSubview:banger];
    
}

#pragma mark 图片点击事件 delegate
- (void)bannerViewTouchWithModel:(id)model
{
    NSLog(@"sssssssssss");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
