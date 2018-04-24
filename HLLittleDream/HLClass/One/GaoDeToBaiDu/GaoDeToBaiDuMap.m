//
//  GaoDeToBaiDuMap.m
//  HLLittleDream
//
//  Created by asd on 2018/4/2.
//  Copyright © 2018年 HLRen. All rights reserved.
//

#import "GaoDeToBaiDuMap.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "HLGaoDeCoverAgeViewController.h"//图层VC
@interface GaoDeToBaiDuMap ()<MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic,strong) UIButton * SinceTheRoadsBtn;//路况按钮
@property (nonatomic,strong) UIButton * coverageBtn;//图层按钮
@end

@implementation GaoDeToBaiDuMap

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"高德模仿百度地图";
    [self creatAndShowMap];
}

//创建并展示地图
- (void)creatAndShowMap
{
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    self.mapView = [[MAMapView alloc] init];
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(64);
    }];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.mapView.delegate = self;
    [self creatSinceTheRoads];//创建路况
    [self creatCoverageBtn];//图层按钮

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 开启定位
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;

}
//创建路况按钮
- (void)creatSinceTheRoads
{
    self.SinceTheRoadsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mapView addSubview:self.SinceTheRoadsBtn];
    [self.SinceTheRoadsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(70);
        make.width.height.mas_equalTo(60);
    }];
    [self.SinceTheRoadsBtn setTitle:@"展示路况" forState:UIControlStateNormal];
    [self.SinceTheRoadsBtn setTitle:@"正展示路况" forState:UIControlStateSelected];
    [self.SinceTheRoadsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.SinceTheRoadsBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    self.SinceTheRoadsBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    self.SinceTheRoadsBtn.backgroundColor = KRandomColor;
    [self.SinceTheRoadsBtn addTarget:self action:@selector(sinceTheRoadsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)sinceTheRoadsBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.mapView.showTraffic = sender.selected;
    
}
//创建图层按钮
- (void)creatCoverageBtn
{
    self.coverageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mapView addSubview:self.coverageBtn];
    [self.coverageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.SinceTheRoadsBtn.mas_bottom).offset(20);
        make.width.height.mas_equalTo(60);
    }];
    [self.coverageBtn setTitle:@"图层" forState:UIControlStateNormal];
    self.coverageBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    self.coverageBtn.backgroundColor = KRandomColor;
    [self.coverageBtn addTarget:self action:@selector(coverageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)coverageBtnClick:(UIButton *)sender
{
    NSLog(@"%@",sender);
    HLGaoDeCoverAgeViewController * coverAgeVC = [HLGaoDeCoverAgeViewController new];
    [self.navigationController presentViewController:coverAgeVC animated:YES completion:nil];
}









@end
