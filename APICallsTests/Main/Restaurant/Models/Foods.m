//
//  Foods.m
//  APICallsTests
//
//  Created by OPSolutions on 09/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "Foods.h"

@implementation Foods

- (id) restaurantId:(NSString *)restaurantId {
    if (self) {
        self.restaurantId = restaurantId;
    }
    return self;
}

+ (instancetype)restaurantId:(NSString *)restaurantId{
    Foods *restaurant = [[Foods alloc] restaurantId:restaurantId];
    return restaurant;
}

@end
