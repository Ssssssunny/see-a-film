//
//  SuggestionVC.m
//  FilmCourier
//
//  Created by SunnyLyr on 16/3/12.
//  Copyright © 2016年 LiYuru. All rights reserved.
//

#import "SuggestionVC.h"

@interface SuggestionVC () {
    UITextField *_inputTF;
}

@end

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation SuggestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"意见反馈";
    [self createButtonItem];//创建ButtonItem
    [self createInputTextField];
    
}
- (void)createInputTextField{
    _inputTF = [[UITextField alloc] initWithFrame:CGRectMake(5, 64 + 20,SCREEN_WIDTH  - 5*2, SCREEN_HEIGHT/3)];
    _inputTF.backgroundColor = [UIColor colorWithRed:255/255.0 green:246/255.0 blue:127/255.0 alpha:0.5];
    _inputTF.contentVerticalAlignment = UIControlContentHorizontalAlignmentLeft;
    _inputTF.layer.cornerRadius = 5;
    _inputTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _inputTF.layer.borderWidth = 0.5;
    _inputTF.layer.masksToBounds = YES;
    
    [_inputTF becomeFirstResponder];
    [self.view addSubview:_inputTF];
    
}



//创建ButtonItem
- (void)createButtonItem{
    //    返回按钮
    __weak typeof(self) weakSelf = self;
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(0,0 , 100, 100);
    [sendButton setTitle:@"          提交" forState:UIControlStateNormal];
     [sendButton setTitle:@"          提交" forState:UIControlStateHighlighted];
    [sendButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *reButton = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    [self.navigationItem setRightBarButtonItem:reButton];
    
    
}

-(void)commit:(UIButton *)button {
    NSString * showMessage = nil;
            if(_inputTF.text.length == 0)
            {
                showMessage = @"您不能提交空意见";
            }
            else
            {
                showMessage = @"感谢您的宝贵意见";
                _inputTF.text = @"";
                [self.navigationController popViewControllerAnimated:YES];
            }
            UIAlertView * suggestionAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:showMessage delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
            suggestionAlert.delegate = self;
            [suggestionAlert show];
            suggestionAlert = nil;
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
