//
//  MineCell.m
//  FilmCourier
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 LiYuru. All rights reserved.
//

#import "MineCell.h"

@implementation MineCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self createCell];
    }
    return self;
}

- (void)createCell{
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 30, 30)];
    self.icon = imageview;
    [self.contentView addSubview:self.icon];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(60, 15, 200, 30)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:20];
    self.title = label;
    [self.contentView addSubview:self.title];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
