//
//  MovieModel.h
//  FilmCourier
//
//  Created by Apple on 16/3/9.
//  Copyright © 2016年 LiYuru. All rights reserved.
//

#import "JSONModel.h"


@interface ImagesModel : JSONModel

@property (nonatomic, copy) NSString *small;
@property (nonatomic, copy) NSString *large;
@property (nonatomic, copy) NSString *medium;

@end









@interface RatingModel : JSONModel

@property (nonatomic, copy) NSString *max;
@property (nonatomic, copy) NSString *average;
@property (nonatomic, copy) NSString *stars;
@property (nonatomic, copy) NSString *min;

@end


@protocol SubjectsModel
@end
@interface SubjectsModel : JSONModel

@property (nonatomic, strong)RatingModel <Optional>*rating;
@property (nonatomic, strong) NSArray <Optional>*genres;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *collect_count;
@property (nonatomic, copy) NSString *original_title;
@property (nonatomic, copy) NSString *subtype;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, strong) ImagesModel *images;
@property (nonatomic, copy) NSString *id;


@end








@interface MovieModel : JSONModel

@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *start;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, strong) NSArray <Optional,SubjectsModel>*subjects;

@end
