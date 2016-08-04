//
//  MyAccountVC.m
//  FilmCourier
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 LiYuru. All rights reserved.
//

#import "MyAccountVC.h"
#import "RegisterVC.h"

#define TXTUSERTAG 100
#define TXTPWDTAG 200
#define cancelButtonTAG 600
#define commitButtonTAG 700
#import "FMDatabase.h"
//定义一个带参的宏
#define NSLOG(value1, value2) if (value1) {NSLog([NSString stringWithFormat:@"%@成功", value2]);}else{NSLog([NSString stringWithFormat:@"%@失败", value2]);}
#define offsetLeftHand      60
#define mainSize    [UIScreen mainScreen].bounds.size
#define rectLeftHand        CGRectMake(61-offsetLeftHand, 90, 40, 65)
#define rectLeftHandGone    CGRectMake(mainSize.width / 2 - 100, vLogin.frame.origin.y - 22, 40, 40)

#define rectRightHand       CGRectMake(imgLogin.frame.size.width / 2 + 60, 90, 40, 65)
#define rectRightHandGone   CGRectMake(mainSize.width / 2 + 62, vLogin.frame.origin.y - 22, 40, 40)
@interface MyAccountVC ()<UITextFieldDelegate> {
    

}

@end

@implementation MyAccountVC{
    UITextField * nameTF;
    UITextField * numberTF;
    FMDatabase * myDatabase;
    NSMutableArray * nameArr;
    NSMutableArray * pwdArr;
    
    UIImageView* imgLeftHand;
    UIImageView* imgRightHand;
    
    UIImageView* imgLeftHandGone;
    UIImageView* imgRightHandGone;
    
    JxbLoginShowType showType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTextField];
}
- (void)createTextField{
    
    
    UIImageView* imgLogin = [[UIImageView alloc] initWithFrame:CGRectMake(mainSize.width / 2 - 211 / 2, 100, 211, 109)];
    imgLogin.image = [UIImage imageNamed:@"owl-login"];
    imgLogin.layer.masksToBounds = YES;
    [self.view addSubview:imgLogin];
    
    imgLeftHand = [[UIImageView alloc] initWithFrame:rectLeftHand];
    imgLeftHand.image = [UIImage imageNamed:@"owl-login-arm-left"];
    [imgLogin addSubview:imgLeftHand];
    
    imgRightHand = [[UIImageView alloc] initWithFrame:rectRightHand];
    imgRightHand.image = [UIImage imageNamed:@"owl-login-arm-right"];
    [imgLogin addSubview:imgRightHand];
    
    UIView* vLogin = [[UIView alloc] initWithFrame:CGRectMake(15, 200, mainSize.width - 30, 220)];
    vLogin.layer.borderWidth = 0.5;
    vLogin.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    vLogin.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vLogin];
    
    imgLeftHandGone = [[UIImageView alloc] initWithFrame:rectLeftHandGone];
    imgLeftHandGone.image = [UIImage imageNamed:@"icon_hand"];
    [self.view addSubview:imgLeftHandGone];
    
    imgRightHandGone = [[UIImageView alloc] initWithFrame:rectRightHandGone];
    imgRightHandGone.image = [UIImage imageNamed:@"icon_hand"];
    [self.view addSubview:imgRightHandGone];
    
    nameTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, vLogin.frame.size.width - 60, 44)];
    nameTF.tag = TXTUSERTAG;
    nameTF.delegate = self;
    nameTF.layer.cornerRadius = 5;
    nameTF.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    nameTF.layer.borderWidth = 0.5;
    nameTF.layer.masksToBounds = YES;
    nameTF.placeholder = @"请输入姓名";
    nameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    nameTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    imgUser.image = [UIImage imageNamed:@"iconfont-user"];
    [nameTF.leftView addSubview:imgUser];
    [vLogin addSubview:nameTF];


    numberTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 90, vLogin.frame.size.width - 60, 44)];
    numberTF.tag = TXTPWDTAG;
    numberTF.delegate = self;
    numberTF.layer.cornerRadius = 5;
    numberTF.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    numberTF.layer.borderWidth = 0.5;
    numberTF.secureTextEntry = YES;
    numberTF.placeholder = @"请输入密码";
    numberTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    numberTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgPwd = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    imgPwd.image = [UIImage imageNamed:@"iconfont-password"];
    [numberTF.leftView addSubview:imgPwd];
    [vLogin addSubview:numberTF];
    
    
    
    
//    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(60, 280, 200, 30)];
//    [button setTitle:@"注册" forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:button];
//    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton * loginButton = [[UIButton alloc]initWithFrame:CGRectMake(60, 320, 200, 30)];
//    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
//    loginButton.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:loginButton];
//    [loginButton addTarget:self action:@selector(loginbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    

    
    
    UIButton * registerButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 150, 140, 44)];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    registerButton.layer.cornerRadius = 5;
    registerButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    registerButton.layer.borderWidth = 0.5;
    [vLogin addSubview:registerButton];
    [registerButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * loginButton = [[UIButton alloc]initWithFrame:CGRectMake(180, 150, 140, 44)];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    loginButton.layer.cornerRadius = 5;
    loginButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    loginButton.layer.borderWidth = 0.5;
    [vLogin addSubview:loginButton];
    [loginButton addTarget:self action:@selector(loginbuttonClick) forControlEvents:UIControlEventTouchUpInside];
   }

//- (void)createData{
//    
//    
//    NSString * dbPath = [NSString stringWithFormat:@"%@/data.db",NSHomeDirectory()];
//    NSLog(@"%@",dbPath);
//    myDatabase = [FMDatabase databaseWithPath:dbPath];
//    [myDatabase open];
//    NSString * createSql = @"create table if not exists infomation(id integer primary key autoincrement,name varchar(20),number integer)";
//    [myDatabase executeUpdate:createSql];
//    
//    [myDatabase executeUpdate:[NSString stringWithFormat:@"insert into infomation(name,number) values('%@',%d)",nameTF.text,[numberTF.text intValue]]];
//    //    NSLog(@"%@,%d",nameTF.text,[numberTF.text intValue]);
//    
//    
//    
//    
//}


- (void)buttonClick{
//    [self createData];
    RegisterVC *registervc = [[RegisterVC alloc]init];
    [self.navigationController pushViewController:registervc animated:YES];
}

- (void)loginbuttonClick{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"data.db"];
    myDatabase = [FMDatabase databaseWithPath:dbPath];
    [myDatabase open];
    //2.5 查找数据
    NSString *selectSql = @"select * from infomation";
    
    FMResultSet *resultSet = [myDatabase executeQuery:selectSql];
    nameArr = [NSMutableArray array];
    pwdArr = [NSMutableArray array];
    //next
    while (resultSet.next) {
        //                NSLog(@"%@  %@", [resultSet stringForColumn:@"name"],[resultSet stringForColumn:@"number"]);
        if ([nameTF.text isEqualToString:@""]) {
            UIAlertView * suggestionAlert1 = [[UIAlertView alloc] initWithTitle:@"请输入用户名" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [suggestionAlert1 show];
            suggestionAlert1 = nil;
            return;
        }
        if ([numberTF.text isEqualToString:@""]) {
            UIAlertView * suggestionAlert1 = [[UIAlertView alloc] initWithTitle:@"请输入密码" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [suggestionAlert1 show];
            suggestionAlert1 = nil;
            return;
        }
      
        if ([nameTF.text isEqualToString:[resultSet stringForColumn:@"name"]]) {
            if ( [numberTF.text isEqualToString:[resultSet stringForColumn:@"number"]]) {
                
                if (self.delegate) {
                    [self.delegate name:nameTF.text isLogin:YES];
                }
                
                
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                UIAlertView * suggestionAlert1 = [[UIAlertView alloc] initWithTitle:@"密码错误" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [suggestionAlert1 show];
                suggestionAlert1 = nil;
            }
            return;
            //            NSLog(@"chenggong");
        }
        else{
             NSLog(@"shibai");
        }
    }
    UIAlertView * suggestionAlert1 = [[UIAlertView alloc] initWithTitle:@"用户不存在" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [suggestionAlert1 show];
    suggestionAlert1 = nil;
   
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:nameTF]) {
        if (showType != JxbLoginShowType_PASS)
        {
            showType = JxbLoginShowType_USER;
            return;
        }
        showType = JxbLoginShowType_USER;
        [UIView animateWithDuration:0.5 animations:^{
            imgLeftHand.frame = CGRectMake(imgLeftHand.frame.origin.x - offsetLeftHand, imgLeftHand.frame.origin.y + 30, imgLeftHand.frame.size.width, imgLeftHand.frame.size.height);
            
            imgRightHand.frame = CGRectMake(imgRightHand.frame.origin.x + 48, imgRightHand.frame.origin.y + 30, imgRightHand.frame.size.width, imgRightHand.frame.size.height);
            
            
            imgLeftHandGone.frame = CGRectMake(imgLeftHandGone.frame.origin.x - 70, imgLeftHandGone.frame.origin.y, 40, 40);
            
            imgRightHandGone.frame = CGRectMake(imgRightHandGone.frame.origin.x + 30, imgRightHandGone.frame.origin.y, 40, 40);
            
            
        } completion:^(BOOL b) {
        }];
        
    }
    else if ([textField isEqual:numberTF]) {
        if (showType == JxbLoginShowType_PASS)
        {
            showType = JxbLoginShowType_PASS;
            return;
        }
        showType = JxbLoginShowType_PASS;
        [UIView animateWithDuration:0.5 animations:^{
            imgLeftHand.frame = CGRectMake(imgLeftHand.frame.origin.x + offsetLeftHand, imgLeftHand.frame.origin.y - 30, imgLeftHand.frame.size.width, imgLeftHand.frame.size.height);
            imgRightHand.frame = CGRectMake(imgRightHand.frame.origin.x - 48, imgRightHand.frame.origin.y - 30, imgRightHand.frame.size.width, imgRightHand.frame.size.height);
            
            
            imgLeftHandGone.frame = CGRectMake(imgLeftHandGone.frame.origin.x + 70, imgLeftHandGone.frame.origin.y, 0, 0);
            
            imgRightHandGone.frame = CGRectMake(imgRightHandGone.frame.origin.x - 30, imgRightHandGone.frame.origin.y, 0, 0);
            
        } completion:^(BOOL b) {
        }];
    }
}

#pragma mark --键盘响应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //    点击空白处,键盘降落
    UITextField * userTF = (id)[self.view viewWithTag:TXTUSERTAG];
    UITextField * pwdTF = (id)[self.view viewWithTag:TXTPWDTAG];
    [userTF resignFirstResponder];
    [pwdTF resignFirstResponder];
}

//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    for(int i = 0;i<3;i++){
//        UITextField * textField = (id)[self.view viewWithTag:30+i];
//
//        [textField resignFirstResponder];
//    }
//}
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
