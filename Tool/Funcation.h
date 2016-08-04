//
//  Function.h
//  Limit
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//navigationItem的左右按钮
typedef enum {
    LEFTBARBUTTON,
    RIGHTBARBUTTON
}Position;

//navigationItem回调Block[无参无返回值]
typedef void (^BarButtonCall)(void);//是一个类型,不是变量

//对按钮.Label等控件二次封装
//第一个参数  title 标题
//image图片
//position位置
//点击返回的回调
@interface Funcation : NSObject
//+ (UIBarButtonItem *)setBarButtonItem:(NSString *)title image:(NSString *)image position:(Position)position callBack:(BarButtonCall)block;
+ (UIBarButtonItem *)setBarButtonItem:(NSString *)title image:(NSString *)image callBack:(SEL)callback target:(id)target;

@end
