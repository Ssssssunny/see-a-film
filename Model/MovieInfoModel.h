//
//  MovieInfoModel.h
//  FilmCourier
//
//  Created by Apple on 16/3/10.
//  Copyright © 2016年 LiYuru. All rights reserved.
//

#import "JSONModel.h"

@interface MovieImagesModel : JSONModel

@property (nonatomic, copy) NSString *small;
@property (nonatomic, copy) NSString *large;
@property (nonatomic, copy) NSString *medium;

@end









@interface MovieRatingModel : JSONModel

@property (nonatomic, copy) NSString *max;
@property (nonatomic, copy) NSString *average;
@property (nonatomic, copy) NSString *stars;
@property (nonatomic, copy) NSString *min;

@end



@interface MovieInfoModel : JSONModel

@property (nonatomic, strong)MovieRatingModel <Optional>*rating;
@property (nonatomic, strong) NSArray <Optional>*genres;
@property (nonatomic, strong) NSArray <Optional>*countries;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *collect_count;
@property (nonatomic, copy) NSString *original_title;
@property (nonatomic, copy) NSString *subtype;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, strong) MovieImagesModel *images;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *ratings_count;
@end
