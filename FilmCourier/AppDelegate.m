//
//  AppDelegate.m
//  FilmCourier
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 LiYuru. All rights reserved.
//

#import "AppDelegate.h"
#import "ListVC.h"

#define TITLE @"title"
#define IMAGE @"image"
#define CLASSNAME @"classname"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 初始化窗体
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    UITabBarController * tabController = [[UITabBarController alloc]init];
    tabController.viewControllers = [self createVC];
    //    属性设置
    self.window.rootViewController = tabController;
    return YES;

}

- (NSArray *)createVC{
    NSMutableArray * contentArray = [NSMutableArray array];
    //    电影界面  title image selectedImage 类名 => 定义成宏
    NSDictionary * filmDict = @{TITLE:@"电影",IMAGE:@"movie",CLASSNAME:@"FilmVC"};
    [contentArray addObject:filmDict];
    //    影院界面
    NSDictionary * CinemaDict = @{TITLE:@"影院",IMAGE:@"cinema",CLASSNAME:@"CinemaVC"};
    [contentArray addObject:CinemaDict];
    
    //    我的界面
    NSDictionary * MineDict = @{TITLE:@"我的",IMAGE:@"user",CLASSNAME:@"MineVC"};
    [contentArray addObject:MineDict];
    
    NSMutableArray * vcArray = [NSMutableArray array];
    for(int i = 0 ;i< contentArray.count;i++){
        NSDictionary * tempDict = [contentArray objectAtIndex:i];
        //        去掉图片的蒙版效果
        UIImage * image = [[UIImage imageNamed:[tempDict objectForKey:IMAGE]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        ListVC * vc = [[NSClassFromString([tempDict objectForKey:CLASSNAME]) alloc]initWithTitle:[tempDict objectForKey:TITLE] image:image];
        
        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:vc];
        [vcArray addObject:nvc];
    }
    return vcArray;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
