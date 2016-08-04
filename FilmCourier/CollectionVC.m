//
//  CollectionVC.m
//  FilmCourier
//
//  Created by SunnyLyr on 16/3/20.
//  Copyright © 2016年 LiYuru. All rights reserved.
//

#import "CollectionVC.h"
#import "CinemaInfoVC.h"
#import "FMDatabase.h"
#import "MineVC.h"
@interface CollectionVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CollectionVC{
    UITableView *collectListTV;//收藏列表
    FMDatabase *myDatabase;
    NSMutableArray *dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self createTableView];
    // Do any additional setup after loading the view.
}
//创建列表TableView
- (void)createTableView{
    collectListTV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    
    UIImageView * bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [bgImageView setImage:[UIImage imageNamed:@"bg3.jpeg"]];
    collectListTV.backgroundView = bgImageView;
    
    collectListTV.delegate = self;
    collectListTV.dataSource = self;
    collectListTV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    collectListTV.bounces = YES;
    [self.view addSubview:collectListTV];
    [self loadData];
    
    
}

-(void)loadData {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    dataArray = [[NSMutableArray alloc] init];
    
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"data.db"];
    myDatabase = [FMDatabase databaseWithPath:dbPath];
    [myDatabase open];
    // 查找数据
    NSString *selectSql = @"select * from loveFilms";
    
    FMResultSet *resultSet = [myDatabase executeQuery:selectSql];
    while (resultSet.next) {
        if ([[MineVC sharedManager] isEqualToString:[resultSet stringForColumn:@"user"]]) {
            
            NSDictionary *oneDict = [NSDictionary dictionaryWithObjects:@[[resultSet stringForColumn:@"filmid" ] ,[resultSet stringForColumn:@"filmname"]] forKeys:@[@"1",@"2"]];
            [dataArray addObject:oneDict];
        }
    }
    [collectListTV reloadData];


}




//实现TableView的协议方法


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * loveCell = @"LOVECELL";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:loveCell];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loveCell];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[dataArray[indexPath.row] objectForKey:@"2"]];
    return cell;
    }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CinemaInfoVC *cinemainfovc = [[CinemaInfoVC alloc]init];
    NSString *movieid = [NSString stringWithFormat:@"%@",[dataArray[indexPath.row] objectForKey:@"1"]];
    NSLog(@"%@",movieid);
    cinemainfovc.movieId =movieid;
    [self.navigationController pushViewController:cinemainfovc animated:YES];
}
//设置tableview可以编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//删除按钮可以点击
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView  beginUpdates];
        NSArray *_tempIndexPathArr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        [tableView deleteRowsAtIndexPaths:_tempIndexPathArr withRowAnimation:UITableViewRowAnimationLeft];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        ;
        
        NSString * userName = [MineVC sharedManager];
        NSString * movieId = [dataArray[indexPath.row] objectForKey:@"1"];
        
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"data.db"];
        myDatabase = [FMDatabase databaseWithPath:dbPath];
        [myDatabase open];
        NSString *selectSql = @"select * from loveFilms";
        FMResultSet *resultSet = [myDatabase executeQuery:selectSql];
        while (resultSet.next) {
            if ([userName isEqualToString:[resultSet stringForColumn:@"user"]]&&[movieId isEqualToString:[resultSet stringForColumn:@"filmid"]]) {
//                NSString *delectsql=[NSString stringWithFormat: @"delete from loveFilms  where user = %@ and filmid =%@",userName,movieId];
                [myDatabase executeUpdate:@"delete from loveFilms  where filmid=?",movieId];
               
            }
        }
        [dataArray removeObjectAtIndex:indexPath.row];
        [tableView endUpdates];
        [tableView reloadData];
    }
}
//将默认delete改成中文
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
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
