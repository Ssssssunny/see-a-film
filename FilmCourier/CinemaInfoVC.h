//
//  CinemaInfoVC.h
//  FilmCourier
//
//  Created by Apple on 16/3/12.
//  Copyright © 2016年 LiYuru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CinemaInfoVC : UIViewController


@property (nonatomic, copy)NSString *movieId;

@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTextL1;
@property (weak, nonatomic) IBOutlet UILabel *movieTextL2;
@property (weak, nonatomic) IBOutlet UILabel *movieTextL3;
@property (weak, nonatomic) IBOutlet UILabel *movieTextL4;
@property (weak, nonatomic) IBOutlet UILabel *movieTextL5;
@property (weak, nonatomic) IBOutlet UILabel *movieTextL6;

@property (weak, nonatomic) IBOutlet UITextView *movieTextV7;

@end
