//
//  FilmCell.h
//  FilmCourier
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 LiYuru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilmCell : UITableViewCell
@property (nonatomic,retain) UIImageView * filmIcon;
@property (nonatomic,retain) UILabel * filmName;
@property (nonatomic,retain) UILabel * originName;
@property (nonatomic,retain) UILabel * year;
@property (nonatomic,retain) UILabel * subtype;
@property (nonatomic,retain) UILabel * averageRating;
@property (nonatomic,retain) UILabel * collectCount;

@end
