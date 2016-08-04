//
//  MineVC.m
//  FilmCourier
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 LiYuru. All rights reserved.
//

#import "MineVC.h"
#import "MineCell.h"
#import "MineModel.h"
#import "MyAccountVC.h"
#import "CollectionVC.h"
#import "SuggestionVC.h"
#import "AboutUsVC.h"
@interface MineVC ()<UITableViewDataSource,UITableViewDelegate,LoginDelegate> {
    UIAlertView * suggestionAlert;
    BOOL isLogin;
    MineModel * zhanghao;
    UIAlertView * suggestionAlert3;
    UIButton *exitButton;
}

@end

@implementation MineVC{
    NSMutableArray * _dataArr;//数据
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createData];
    isLogin = NO;
}

- (void)createTableView{
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    
    UIImageView * bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [bgImageView setImage:[UIImage imageNamed:@"bg3.jpeg"]];
    self.listTableView.backgroundView = bgImageView;
    
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.listTableView.bounces = NO;
    [self.view addSubview:self.listTableView];
    
    
    
}

- (void)createData{
    //代表段数
    _dataArr = [[NSMutableArray alloc] init];
    
    //内层数组   代表第一段的所有数据
   // NSMutableArray *dataArray1 = [[NSMutableArray alloc] init];
    
    zhanghao = [[MineModel alloc]init];
    zhanghao.icon = @"account_ic@2x";
    zhanghao.name = @"未登录";
    [_dataArr addObject:zhanghao];
    
    //存放第二段所有数据
   // NSMutableArray *dataArray2 = [[NSMutableArray alloc] init];
    
    MineModel * shoucang = [[MineModel alloc]init];
    shoucang.icon = @"collect_ic@2x";
    shoucang.name = @"我的收藏";
    
    [_dataArr addObject:shoucang];
    
    //存放第三段所有数据
   // NSMutableArray *dataArray3 = [[NSMutableArray alloc] init];
    
      MineModel * yijian = [[MineModel alloc]init];
    yijian.icon = @"bg_comment_light@2x";
    yijian.name = @"意见反馈";
    [_dataArr addObject:yijian];
    
    MineModel * guanyu = [[MineModel alloc]init];
    guanyu.icon = @"mark_star_ic@2x";
    guanyu.name = @"关于我们";
    
    [_dataArr addObject:guanyu];
    //存放第四段所有数据
//    NSMutableArray *dataArray4 = [[NSMutableArray alloc] init];
//    MineModel * qingchu = [[MineModel alloc]init];
//    qingchu.icon = @"del_ic_1@2x";
//    qingchu.name = @"清除缓存";
//    [dataArray4 addObject:qingchu];
    
//    [_dataArr addObject:dataArray4];
    
    [self.listTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    如果子类Cell高度为100,则不需重载方法
    return 60;
}
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section

{
    
    return 0.1 ;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
     return 0.1 ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * mineCell = @"MineCELL";
    MineCell * cell = [tableView dequeueReusableCellWithIdentifier:mineCell];
    if(!cell){
        cell = [[MineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineCell];
        cell.backgroundColor = [UIColor clearColor];
    }
    if (indexPath.row == 4) {
        if (![[MineVC sharedManager] isEqualToString:@""]) {
            exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
            exitButton.frame =CGRectMake(0, 0, self.view.frame.size.width, 60);
            exitButton.backgroundColor = [UIColor clearColor];
            [exitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
            [exitButton addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:exitButton];
        }else {
            [exitButton removeFromSuperview];
        }
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右侧箭头
        MineModel * _mineModel = [_dataArr objectAtIndex:indexPath.row];
        cell.icon.image = [UIImage imageNamed:_mineModel.icon];
        cell.title.text = _mineModel.name;
  }
    return cell;
}


-(void)exit:(UIButton *)button {
    suggestionAlert3 = [[UIAlertView alloc] initWithTitle:@"确定要退出么" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [suggestionAlert3 show];

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0){
        if (isLogin == NO) {
            MyAccountVC * myAcc = [[MyAccountVC alloc]init];
            myAcc.delegate = self;
            [self.navigationController pushViewController:myAcc animated:YES];
        }
    }else  if (indexPath.row == 1) {
        if ([[MineVC sharedManager] isEqualToString:@""]) {
            UIAlertView * suggestionAlert2 = [[UIAlertView alloc] initWithTitle:@"请先登录" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [suggestionAlert2 show];
            suggestionAlert2 = nil;
            return;
        }
        
        CollectionVC *collectionVc = [[CollectionVC alloc] init];
        [self.navigationController pushViewController:collectionVc animated:YES];
    }else  if (indexPath.row == 2) {
        SuggestionVC *suggVc = [[SuggestionVC alloc] init];
        [self.navigationController pushViewController:suggVc animated:YES];
    }else  if (indexPath.row == 3) {
        AboutUsVC *aboutVC = [[AboutUsVC alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
//    }else  if (indexPath.row == 0 && indexPath.section == 2) {
//        NSString *showMessage=@"确定要清理缓存吗？";
//        suggestionAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:showMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//        suggestionAlert.delegate = self;
//        [suggestionAlert show];
//        
    }
    else{
    NSLog(@"aaa");
    }
    
   
}

-(void)name:(NSString *)name isLogin:(BOOL)login {
    zhanghao.name = [NSString stringWithFormat:@"昵称：%@(已登录)",name];
    [self.listTableView  reloadData];
    isLogin = login;
    NSMutableString *nameStr = [MineVC sharedManager];
    nameStr.string = name;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && alertView == suggestionAlert) {
        UIAlertView * suggestionAlert1 = [[UIAlertView alloc] initWithTitle:@"清理成功" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [suggestionAlert1 show];
        suggestionAlert = nil;
        suggestionAlert1 = nil;
    }else if (buttonIndex == 0 && alertView == suggestionAlert3) {
        NSMutableString *nameStr = [MineVC sharedManager];
        nameStr.string = @"";
        zhanghao.name = @"未登录";
        suggestionAlert3 = nil;
        isLogin = NO;
        [self.listTableView reloadData];
    }

}


+ (NSMutableString *)sharedManager
{
    static NSMutableString *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[NSMutableString alloc] initWithString:@""];
    });
    return sharedAccountManagerInstance;
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
