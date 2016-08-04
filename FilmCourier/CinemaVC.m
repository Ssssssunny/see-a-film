//
//  CinemaVC.m
//  FilmCourier
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 LiYuru. All rights reserved.
//

#import "CinemaVC.h"
#import "LocationVC.h"
#import "CinemaCell.h"
#import "CinemaModel.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
@interface CinemaVC ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>

@end

@implementation CinemaVC{
    NSMutableArray * _dataArr;//数据源
    NSDictionary * _dic;//请求数据(字典)
    CinemaModel * _cinemaModel;
    MBProgressHUD *HUD;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak CinemaVC * vc = self;
    [self downloadGet];
//    self.listTableView.userInteractionEnabled = YES;//打开用户接口

    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    HUD.delegate =self;
    HUD.labelText = @"加载中...";
    HUD.dimBackground = YES;
    [self.view addSubview:HUD];
    [HUD show:YES];
}

- (void)downloadGet{
    
    
    AFHTTPRequestOperationManager * manage = [AFHTTPRequestOperationManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage GET:[CinemaURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        _dataArr = [NSMutableArray array];
        NSMutableArray * mArray = [NSMutableArray array];
        
//        if([[_dic objectForKey:@"result"] isKindOfClass:[NSArray class]]){
            mArray = [[_dic objectForKey:@"result"] objectForKey:@"data"];
            for(int i = 0 ;i< [mArray count];i++)
            {
                _cinemaModel = [[CinemaModel alloc]init];
                for(NSString * item in [mArray[i] allKeys])
                {
                    if([item isEqualToString:@"cinemaName"]){
                        _cinemaModel.cinemaname = [mArray[i] objectForKey:item];
                    }else if([item isEqualToString:@"address"]){
                        _cinemaModel.cinemaaddress = [mArray[i] objectForKey:item];
                    }else if([item isEqualToString:@"telephone"]){
                        _cinemaModel.cinematel = [mArray[i] objectForKey:item];
                    }else if([item isEqualToString:@"trafficRoutes"]){
                        _cinemaModel.cinemaroutes = [mArray[i] objectForKey:item];
                    }else if([item isEqualToString:@"latitude"]){
                        _cinemaModel.cinemalatitude = [mArray[i] objectForKey:item];
                    }else if([item isEqualToString:@"longitude"]){
                        _cinemaModel.cinemalongitude = [mArray[i] objectForKey:item];
                    }else if([item isEqualToString:@"id"]){
                        _cinemaModel.cinemaid = [mArray[i] objectForKey:item];
                    }else{
                        
                    }
                }
                [_dataArr addObject:_cinemaModel];
            }
            [HUD hide:YES];
            [[self listTableView] reloadData];//请求完成刷新

//        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误信息:%@",error.localizedDescription);
    }];
    
    
}//AF



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    如果子类Cell高度为100,则不需重载方法
    return 220;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * filmCell = @"FILMCELL";
    CinemaCell * cell = [tableView dequeueReusableCellWithIdentifier:filmCell];
    if(!cell){
        cell = [[CinemaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:filmCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右侧箭头
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.userInteractionEnabled = YES;
    _cinemaModel = _dataArr[indexPath.row];
    cell.cinemaName.text = _cinemaModel.cinemaname;
    cell.cinemaAddress.text = [NSString stringWithFormat:@"地址:%@",_cinemaModel.cinemaaddress];
    cell.cinemaTel.text = [NSString stringWithFormat:@"Tel:%@",_cinemaModel.cinematel];
    cell.cinematrafficRoutes.text = [NSString stringWithFormat:@"路线:%@",_cinemaModel.cinemaroutes];
    cell.cinemaLocation.tag = indexPath.row;
//    [cell.cinemaLocation addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)click:(UIButton *)btn{
    //   将值模态传过去
    _cinemaModel = _dataArr[btn.tag];
    NSString * nameStr = _cinemaModel.cinemaname;
    NSString * addressStr = _cinemaModel.cinemaaddress;
    NSString * latitudeStr = _cinemaModel.cinemalatitude;
    NSString * longitudeStr =_cinemaModel.cinemalongitude;
    LocationVC * location = [[LocationVC alloc]init];
    location.locName = nameStr;
    location.locAddress = addressStr;
    location.locLatitude = latitudeStr;
    location.locLongitude = longitudeStr;
    NSLog(@"%@",latitudeStr);
    [self.navigationController pushViewController:location animated:YES];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * nameStr = _cinemaModel.cinemaname;
    NSString * addressStr = _cinemaModel.cinemaaddress;
    NSString * latitudeStr = _cinemaModel.cinemalatitude;
    NSString * longitudeStr =_cinemaModel.cinemalongitude;
    LocationVC * location = [[LocationVC alloc]init];
    location.locName = nameStr;
    location.locAddress = addressStr;
    location.locLatitude = latitudeStr;
    location.locLongitude = longitudeStr;
    [self.navigationController pushViewController:location animated:YES];

}
- (void)viewWillAppear:(BOOL)animated{
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
