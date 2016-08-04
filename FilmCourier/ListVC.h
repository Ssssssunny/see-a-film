//
//  ListVC.h
//  FilmCourier
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 LiYuru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListVC : UIViewController

//重写一个初始化方法  初始化navigationItem的title tarbarItem


@property (nonatomic, strong)UITableView * listTableView;

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image;

//返回TableView (get方法)
- (UITableView *)listTableView;
//左按钮回调
- (void)leftCallBack;
//右按钮回调
- (void)rightCallBack;

//设置cell的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
