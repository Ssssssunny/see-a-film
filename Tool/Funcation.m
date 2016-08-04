//
//  Function.m
//  Limit
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Funcation.h"

@implementation Funcation

+ (UIBarButtonItem *)setBarButtonItem:(NSString *)title image:(NSString *)image callBack:(SEL)callback target:(id)target{
//    自定义一个button
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    设置button的frame
    [button setFrame:CGRectMake(0, 0, 44, 30)];
    
//    设置button的图片
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//    设置button的标题
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    设置回调
    [button addTarget:target action:callback forControlEvents:UIControlEventTouchUpInside];
//    自定义BarButton
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button];
//返回barbuttonItem
    return item;
}

@end
