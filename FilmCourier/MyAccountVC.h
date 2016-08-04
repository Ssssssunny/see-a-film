//
//  MyAccountVC.h
//  FilmCourier
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 LiYuru. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginDelegate <NSObject>

-(void)name:(NSString *)name isLogin:(BOOL)login;

@end

typedef NS_ENUM(NSInteger, JxbLoginShowType) {
    JxbLoginShowType_NONE,
    JxbLoginShowType_USER,
    JxbLoginShowType_PASS
};


@interface MyAccountVC : UIViewController

@property (nonatomic ,weak) id<LoginDelegate>delegate;

@end
