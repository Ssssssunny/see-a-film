//
//  CinemaInfoVC.m
//  FilmCourier
//
//  Created by Apple on 16/3/12.
//  Copyright © 2016年 LiYuru. All rights reserved.
//


#import "CinemaInfoVC.h"
#import "FMDatabase.h"
#import "AFNetworking.h"
#import "MovieInfoModel.h"
#import "UIImageView+WebCache.h"
#import "MineVC.h"
@interface CinemaInfoVC () {
    FMDatabase * myDatabase;
    
}

@end

@implementation CinemaInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
}

-(void)loadUI {
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(0,0 , 100, 100);
    [sendButton setTitle:@"          收藏" forState:UIControlStateNormal];
    [sendButton setTitle:@"          收藏" forState:UIControlStateHighlighted];
    [sendButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(love) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *reButton = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    [self.navigationItem setRightBarButtonItem:reButton];

}

-(void)loadData:(MovieInfoModel *)movieInfo {
    [_movieImage sd_setImageWithURL:[NSURL URLWithString:movieInfo.images.large] placeholderImage:nil];
    
    _movieTextL1.text=movieInfo.title;
    _movieTextL3.text = [NSString stringWithFormat:@"评分 ：%@(%@评论)",movieInfo.rating.average,movieInfo.ratings_count];
    _movieTextL4.text = [NSString stringWithFormat:@"上映年份：%@",movieInfo.year];
    NSMutableString *movieType = [[NSMutableString alloc] initWithString:@""];
    for (NSString *obj in movieInfo.genres) {
        if ([movieType isEqualToString:@""]) {
          movieType =   [NSMutableString stringWithFormat:@"%@",[movieType stringByAppendingString:obj]];
        }else {
            movieType =   [NSMutableString stringWithFormat:@"%@",[movieType stringByAppendingString:[NSString stringWithFormat:@"/%@",obj]]];
            
        }
        NSLog(@"%@",movieType);
    }
    _movieTextL2.text= [NSString stringWithFormat:@"原名：%@",movieInfo.original_title];
    _movieTextL5.text = movieType;
    _movieTextL6.text = movieInfo.countries[0];
    _movieTextV7.editable = NO;
    _movieTextV7.text = movieInfo.summary;
}


-(void)setMovieId:(NSString *)movieId {
    _movieId = movieId;
    NSString *movieInfoURL = [NSString stringWithFormat:FilmMessageURL,movieId];
    [self downloadGetWith:movieInfoURL];
}


- (void)downloadGetWith:(NSString *)movieInfoURL{
    
    
    AFHTTPRequestOperationManager * manage = [AFHTTPRequestOperationManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage GET:[movieInfoURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MovieInfoModel *movieInfoModel = [[MovieInfoModel alloc] initWithData:responseObject error:nil];
        
        [self loadData:movieInfoModel];
        [self loadUI];
        
        
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误信息:%@",error.localizedDescription);
    }];
    
    
}
- (void)love{
    
    
    if ([[MineVC sharedManager] isEqualToString:@""]) {
        UIAlertView * suggestionAlert2 = [[UIAlertView alloc] initWithTitle:@"请先登录" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [suggestionAlert2 show];
        suggestionAlert2 = nil;
        return;
    }


    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"data.db"];
    myDatabase = [FMDatabase databaseWithPath:dbPath];
    [myDatabase open];
    NSString * createSql = @"create table if not exists loveFilms(id integer primary key autoincrement,user varchar(20),filmid varchar(20),filmname varchar(50))";
    [myDatabase executeUpdate:createSql];
    
    [myDatabase executeUpdate:[NSString stringWithFormat:@"insert into loveFilms(user,filmid,filmname) values('%@',%@,'%@')",[MineVC sharedManager],_movieId,_movieTextL1.text]];
        NSLog(@"%@---%@",_movieId,_movieTextL1.text);
    UIAlertView * suggestionAlert = [[UIAlertView alloc] initWithTitle:@"已收藏" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [suggestionAlert show];
 
}
//界面显示时隐藏底部TabBar
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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
