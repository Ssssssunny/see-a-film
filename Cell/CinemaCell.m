//
//  CinemaCell.m
//  FilmCourier
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 LiYuru. All rights reserved.
//

#import "CinemaCell.h"

@implementation CinemaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self createCell];
    }
    return self;
}

- (void)createCell{
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 350, 190)];
    [self.contentView addSubview:imageView];
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 350, 30)];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:25];
    self.cinemaName = nameLabel;
    [imageView addSubview:self.cinemaName];
    
    UILabel * addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 53, 320, 47)];
    addressLabel.textColor = [UIColor blackColor];
    addressLabel.font = [UIFont systemFontOfSize:18];
    addressLabel.numberOfLines = 0;
    addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.cinemaAddress = addressLabel;
    [imageView addSubview:self.cinemaAddress];

    UILabel * telLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 200, 30)];
    telLabel.textColor = [UIColor darkGrayColor];
    telLabel.font = [UIFont systemFontOfSize:18];
    self.cinemaTel = telLabel;
    [imageView addSubview:self.cinemaTel];
    
    UIButton * location = [[UIButton alloc]initWithFrame:CGRectMake(270, 100, 30, 30)];
    [location setBackgroundImage:[UIImage imageNamed:@"icon_spot"] forState:UIControlStateNormal];
    
//    location.backgroundColor = [UIColor blackColor];
    self.cinemaLocation = location;
    [imageView addSubview:self.cinemaLocation];
//    
//    UILabel * locLabel = [[UILabel alloc]initWithFrame:CGRectMake(335, 50, 20, 30)];
//    locLabel.textColor = [UIColor blackColor];
//    locLabel.text = @"看位置";
//    locLabel.font = [UIFont systemFontOfSize:15];
//    self.cinemaLoc = locLabel;
//    [self.contentView addSubview:self.cinemaLoc];

    
    UILabel * routesLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 130, 350, 60)];
    routesLabel.textColor = [UIColor darkGrayColor];
    routesLabel.font = [UIFont systemFontOfSize:15];
    routesLabel.numberOfLines = 0;
    routesLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.cinematrafficRoutes = routesLabel;
    [imageView addSubview:self.cinematrafficRoutes];

   }


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
