//
//  FilmVC.m
//  FilmCourier
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 LiYuru. All rights reserved.
//

#import "FilmVC.h"
#import "FilmCell.h"
#import "FilmModel.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "MovieModel.h"
#import "CinemaInfoVC.h"
@interface FilmVC ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>

@end

@implementation FilmVC{
    NSMutableArray * _dataArr;//数据源
    NSDictionary * _dic;//请求数据(字典)
    SubjectsModel *_subjectModel;
    MBProgressHUD *HUD;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    __weak FilmVC * vc = self;
    [self downloadGet];
 
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    HUD.delegate =self;
    HUD.labelText = @"加载中...";
    HUD.dimBackground = YES;
    [self.view addSubview:HUD];
    [HUD show:YES];
    
     _dataArr = [NSMutableArray array];
}

- (void)downloadGet{
    
    
    AFHTTPRequestOperationManager * manage = [AFHTTPRequestOperationManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage GET:[FilmURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MovieModel *movieModel = [[MovieModel alloc] initWithData:responseObject error:nil];
     
        [_dataArr addObjectsFromArray:movieModel.subjects];;
        
        
        [HUD hide:YES];
        [[self listTableView] reloadData];//请求完成刷新
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误信息:%@",error.localizedDescription);
    }];
    
    
}//AF



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    如果子类Cell高度为100,则不需重载方法
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * filmCell = @"FILMCELL";
    FilmCell * cell = [tableView dequeueReusableCellWithIdentifier:filmCell];
    if(!cell){
        cell = [[FilmCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:filmCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右侧箭头
        cell.backgroundColor = [UIColor clearColor];
    }
    _subjectModel = _dataArr[indexPath.row];
    NSURL * iconURL = [NSURL URLWithString:_subjectModel.images.large];
    [cell.filmIcon sd_setImageWithURL:iconURL];
    cell.filmName.text = _subjectModel.title;
    cell.originName.text=[NSString stringWithFormat:@"(原名 : %@)",_subjectModel.original_title];
    NSMutableString *movieType = [[NSMutableString alloc] initWithString:@""];
    for (NSString *obj in _subjectModel.genres) {
        if ([movieType isEqualToString:@""]) {
            movieType =   [NSMutableString stringWithFormat:@"%@",[movieType stringByAppendingString:obj]];
        }else {
            movieType =   [NSMutableString stringWithFormat:@"%@",[movieType stringByAppendingString:[NSString stringWithFormat:@"/%@",obj]]];
            
        }
    }
    cell.subtype.text=[NSString stringWithFormat:@"类型 : %@",movieType];//类型
    cell.year.text=[NSString stringWithFormat:@"上映年份 : %@",_subjectModel.year];
    cell.averageRating.text=[NSString stringWithFormat:@"豆瓣评分 : %@",_subjectModel.rating.average];//评分
    cell.collectCount.text= [NSString stringWithFormat:@"收藏次数 : %@",_subjectModel.collect_count];//收藏数
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CinemaInfoVC *cinemaInfo = [[CinemaInfoVC alloc]init];
    SubjectsModel *oneSubject = _dataArr[indexPath.row];
    cinemaInfo.movieId = oneSubject.id;
    [self.navigationController pushViewController:cinemaInfo animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}





- (void)leftCallBack{
    NSLog(@"点击了左按钮");
}
- (void)rightCallBack{
    NSLog(@"点击了右按钮");
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
