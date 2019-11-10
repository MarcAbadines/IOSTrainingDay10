//
//  Foods.h
//  APICallsTests
//
//  Created by OPSolutions on 09/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Foods : NSObject

@property (strong, nonatomic) NSString *restaurantId;
@property (strong, nonatomic) NSString *restaurantName;
@property (strong, nonatomic) NSString *restaurantAddress;
@property (strong, nonatomic) NSString *restaurantThumb;
@property (assign) float restaurantUserRating;
@property (assign) float restaurantAggregateRating;
@property (strong, nonatomic) NSString *restaurantCuisines;
@property (strong, nonatomic) NSString *restaurantTiming;
@property (strong, nonatomic) NSString *restaurantReviews;
@property (assign) float restaurantAverageCostForTwo;


- (id) restaurantId:(NSString *)restaurantId;
+ (instancetype) restaurantId:(NSString *)restaurantId;


@end

NS_ASSUME_NONNULL_END
