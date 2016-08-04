//
//  ListVC.m
//  FilmCourier
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 LiYuru. All rights reserved.
//

#import "ListVC.h"
//导入头文件
#import "LimitHeader.h"
//导入工具函数头文件
#import "Funcation.h"
//导入上拉下拉刷新头文件
#import "MJRefresh.h"
//定义屏幕的宽高
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height
//TableView协议
@interface ListVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ListVC{
    //    列表tableView
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.navigationItem设置
//    [self createNavigationItem];
//    [self createBgImage];
    //2.tableView设置
    [self createTableView];
    self.tabBarController.tabBar.backgroundColor = [UIColor redColor];
}
- (void)createBgImage{
    UIImageView * navImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//    navImg.backgroundColor = [UIColor redColor];
//    navImg.image = [UIImage imageNamed:@"标题栏底"];
    [self.navigationController.navigationBar addSubview:navImg];
}
#pragma mark 1.navigationItem设置

- (void)createNavigationItem{
    //    左按钮设置
    self.navigationItem.leftBarButtonItem = [Funcation setBarButtonItem:@"分类" image:@"buttonbar_action" callBack:@selector(leftCallBack) target:self];
    //    右按钮设置
    self.navigationItem.rightBarButtonItem = [Funcation setBarButtonItem:@"设置" image:@"buttonbar_action" callBack:@selector(rightCallBack) target:self];
}


- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image{
    if(self = [super init]){
        
        //        设置tabBarItem
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:image selectedImage:nil];
        //        设置navigationItem的title
        self.title = title;
        
    }
    return self;
}

//返回TableView (get方法)
- (UITableView *)listTableView{
    return _listTableView;
}



#pragma mark 2.tableView设置
//创建列表TableView
- (void)createTableView{
    _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    
    UIImageView * bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [bgImageView setImage:[UIImage imageNamed:@"bg3.jpeg"]];
    _listTableView.backgroundView = bgImageView;
    
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _listTableView.bounces = NO;
    [self.view addSubview:_listTableView];
    


}

//实现TableView的协议方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    如果子类Cell高度为100,则不需重载方法
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    待子类需要时,重载
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    待子类需要时,重载
    return nil;
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
