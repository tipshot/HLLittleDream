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
@interface GaoDeToBaiDuMap ()<MAMapViewDelegate>

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
    ///初始化地图
    MAMapView *_mapView = [[MAMapView alloc] init];
    _mapView.delegate = self;
    ///把地图添加至view
    [self.view addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(64);
    }];
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
//    r.showsAccuracyRing = NO;///精度圈是否显示，默认YES
//    r.showsHeadingIndicator = NO;///是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)。默认为YES
    r.fillColor = [UIColor redColor];///精度圈 填充颜色, 默认 kAccuracyCircleDefaultColor
    r.strokeColor = [UIColor blueColor];///精度圈 边线颜色, 默认 kAccuracyCircleDefaultColor
    r.lineWidth = 2;///精度圈 边线宽度，默认0
//    r.enablePulseAnnimation = NO;///内部蓝色圆点是否使用律动效果, 默认YES
    r.locationDotBgColor = [UIColor greenColor];///定位点背景色，不设置默认白色
    r.locationDotFillColor = [UIColor grayColor];///定位点蓝色圆点颜色，不设置默认蓝色
    [_mapView updateUserLocationRepresentation:r];

    
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    MAAnnotationView * annoView = [MAAnnotationView new];
    annoView.backgroundColor = KRandomColor;
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return annoView;
    }else{
        return annoView;
    }
    
}






@end
