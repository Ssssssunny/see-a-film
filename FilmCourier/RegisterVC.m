//
//  RegisterVC.m
//  FilmCourier
//
//  Created by SunnyLyr on 16/3/13.
//  Copyright © 2016年 LiYuru. All rights reserved.
//

#import "RegisterVC.h"
#import "FMDatabase.h"

@interface RegisterVC (){
    UITextField * nameTF;
    UITextField * numberTF;
    UITextField *numberAgainTF;
    FMDatabase * myDatabase;
}

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self createTextField];
    // Do any additional setup after loading the view.
}
- (void)createTextField{
    
    nameTF = [[UITextField alloc]initWithFrame:CGRectMake(30, 100, SCREEN_WIDTH-30*2, 45)];
    nameTF.backgroundColor = [UIColor whiteColor];
    nameTF.layer.cornerRadius = 5;
    nameTF.layer.borderWidth = 1;
    nameTF.layer.borderColor = [UIColor grayColor].CGColor;
    nameTF.layer.masksToBounds = YES;
    nameTF.placeholder = @"请输入姓名";
    nameTF.tag = 100;
    [self.view addSubview:nameTF];
    
    numberTF = [[UITextField alloc]initWithFrame:CGRectMake(30, 165, SCREEN_WIDTH-30*2, 45)];
    numberTF.layer.cornerRadius = 5;
    numberTF.layer.borderWidth = 1;
    numberTF.secureTextEntry = YES;
    numberTF.layer.borderColor = [UIColor grayColor].CGColor;
    numberTF.layer.masksToBounds = YES;
    numberTF.backgroundColor = [UIColor whiteColor];
    numberTF.placeholder = @"请输入密码";
    [self.view addSubview:numberTF];
    
    numberAgainTF = [[UITextField alloc]initWithFrame:CGRectMake(30, 230, SCREEN_WIDTH-30*2, 45)];
    numberAgainTF.layer.cornerRadius = 5;
    numberAgainTF.layer.borderWidth = 1;
    numberAgainTF.secureTextEntry = YES;
    numberAgainTF.layer.borderColor = [UIColor grayColor].CGColor;
    numberAgainTF.layer.masksToBounds = YES;
    numberAgainTF.backgroundColor = [UIColor whiteColor];
    numberAgainTF.placeholder = @"请再次输入密码";
    [self.view addSubview:numberAgainTF];
    
    UIButton * button1 = [[UIButton alloc]initWithFrame:CGRectMake(30, 290, (SCREEN_WIDTH-30*2-15)/2, 40)];
    [button1 setTitle:@"注册" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor whiteColor];
    button1.layer.cornerRadius = 5;
    button1.layer.borderWidth = 1;
    button1.layer.borderColor = [UIColor grayColor].CGColor;
    button1.layer.masksToBounds = YES;
    [self.view addSubview:button1];
    [button1 addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * button2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-(SCREEN_WIDTH-30*2-15)/2-40, 290, (SCREEN_WIDTH-30*2-15)/2, 40)];
    [button2 setTitle:@"取消" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor whiteColor];
    button2.layer.cornerRadius = 5;
    button2.layer.borderWidth = 1;
    button2.layer.borderColor = [UIColor grayColor].CGColor;
    button2.layer.masksToBounds = YES;
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)buttonClick{
    
    if (![numberTF.text isEqualToString:numberAgainTF.text]) {
        UIAlertView * suggestionAlert1 = [[UIAlertView alloc] initWithTitle:@"两次密码不一致！" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [suggestionAlert1 show];
        suggestionAlert1 = nil;
        return;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"data.db"];
    myDatabase = [FMDatabase databaseWithPath:dbPath];
    [myDatabase open];
    NSString * createSql = @"create table if not exists infomation(id integer primary key autoincrement,name varchar(20),number integer)";
    [myDatabase executeUpdate:createSql];
    
    [myDatabase executeUpdate:[NSString stringWithFormat:@"insert into infomation(name,number) values('%@',%d)",nameTF.text,[numberTF.text intValue]]];
        NSLog(@"%@,%d",nameTF.text,[numberTF.text intValue]);
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(void)cancelButtonClick{
    nameTF.text=@"";
    numberTF.text=@"";
    numberAgainTF.text=@"";
//    [self.navigationController popViewControllerAnimated:YES];
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
