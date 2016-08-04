//
//  LocationVC.m
//  FilmCourier
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 LiYuru. All rights reserved.
//

#import "LocationVC.h"
#import <MapKit/MapKit.h>
@interface LocationVC ()<MKMapViewDelegate>

@end

@implementation LocationVC{
//    定义一个地图画布
    MKMapView * _mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    展示地图
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    NSLog(@"%@===%@",_locLatitude,_locLongitude);
//    地图定位置   (经度,纬度)
    CLLocationCoordinate2D centerLocation = CLLocationCoordinate2DMake([_locLatitude floatValue], [_locLongitude floatValue]);
//    地图范围     跨越的经纬度
    MKCoordinateSpan span = MKCoordinateSpanMake(50, 50);
//    调用MKCoordinateRegionMake  创建一个区域结构体
    MKCoordinateRegion region = MKCoordinateRegionMake(centerLocation, span);
//    设置区域(位置)
    [_mapView setRegion:region animated:YES];
    //    设置代理 (为了渲染大头针)
        _mapView.delegate = self;
//    加载到视图上
    [self.view addSubview:_mapView];
    
    
    //    使用系统大头针
    //    创建大头针对象
    MKPointAnnotation * annotation = [[MKPointAnnotation alloc]init];
    //    设置大头针位置  经纬度
    [annotation setCoordinate:CLLocationCoordinate2DMake([_locLatitude floatValue], [_locLongitude floatValue])];
    //    设置大头针注释
    annotation.title = _locName;
    
    //    设置大头针子标题
    annotation.subtitle = _locAddress;
    
    //    添加大头针到mapView
    [_mapView addAnnotation:annotation];

    
    CLLocation * location = [[CLLocation alloc]initWithLatitude:[_locLatitude floatValue] longitude:[_locLongitude floatValue]];
//    反编码
    CLGeocoder * geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:@"北京" completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error){
            NSLog(@"编码失败:%@",error);
        }else{
            CLPlacemark * placemark = [placemarks lastObject];
//            NSLog(@"编码成功:%@",[placemark location]);
            }
//        改显示范围
        CLLocationCoordinate2D topLeftCoord;
        topLeftCoord.latitude = -90;
        topLeftCoord.longitude = 180;
        
        CLLocationCoordinate2D bottomRightCoord;
        bottomRightCoord.latitude = 90;
        bottomRightCoord.longitude = -180;
        
        for(id<MKAnnotation> annotation in _mapView.annotations) {
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
        }
        MKCoordinateRegion region;
        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
        region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1;
        
        // Add a little extra space on the sides
        region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1;
        region = [_mapView regionThatFits:region];
        [_mapView setRegion:region animated:YES];
     }];
    
}
#pragma mark --实现大头针渲染代理方法(重绘)
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //    复用     类似tableViewCell
    static NSString * astring = @"ANNOTATION";
    MKPinAnnotationView * pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:astring];
    
    if(!pinView){
        pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:astring];
    }
    //    MKPinAnnotationView  可以设置颜色
    pinView.pinColor = MKPinAnnotationColorPurple;
    //    设置自定义图片
//    pinView.image = [UIImage imageNamed:@"01"];
    return pinView;
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
