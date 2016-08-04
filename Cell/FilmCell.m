//
//  FilmCell.m
//  FilmCourier
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 LiYuru. All rights reserved.
//

#import "FilmCell.h"

@implementation FilmCell{
    UIImageView * iconIV ;
    UILabel * nameLabel;
    UILabel *originNameLabel;
    UILabel * yearLabel;
    UILabel * subtypeLabel;
    UILabel * originalTitleLabel;
    UILabel *collectCountLabel;
    UILabel * averageRatingLabel;
    UILabel * maxRatingLabel;
    UILabel * minRatingLabel;
    
    

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self createCell];
    }
    return self;
}

- (void)createCell{
    iconIV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 120, 160)];
    self.filmIcon = iconIV;
    [self.contentView addSubview:self.filmIcon];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 15, 200, 30)];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:18];
    self.filmName = nameLabel;
    [self.contentView addSubview:self.filmName];
    
    originNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 53, 200, 15)];
    originNameLabel.textColor = [UIColor blackColor];
    originNameLabel.font = [UIFont systemFontOfSize:15];
    self.originName = originNameLabel;
    [self.contentView addSubview:self.originName];
    
    yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 73, 200, 15)];
    yearLabel.textColor = [UIColor blackColor];
    yearLabel.font = [UIFont systemFontOfSize:15];
    self.year = yearLabel;
    [self.contentView addSubview:self.year];
    
    averageRatingLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 93, 200, 15)];
    averageRatingLabel.textColor = [UIColor blackColor];
    averageRatingLabel.font = [UIFont systemFontOfSize:15];
    self.averageRating = averageRatingLabel;
    [self.contentView addSubview:self.averageRating];
    
    subtypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 123, 200, 15)];
    subtypeLabel.textColor = [UIColor blackColor];
    subtypeLabel.font = [UIFont systemFontOfSize:15];
    self.subtype = subtypeLabel;
    [self.contentView addSubview:self.subtype];
//
    collectCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 143, 200, 15)];
    collectCountLabel.textColor = [UIColor blackColor];
    collectCountLabel.font = [UIFont systemFontOfSize:15];
    self.collectCount = collectCountLabel;
    [self.contentView addSubview:self.collectCount];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
