//
//  Categories.m
//  APICallsTests
//
//  Created by OPSolutions on 08/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "Categories.h"

@implementation Categories

- (id)categoryId:(int)categoryId name:(NSString *)name {
    if (self) {
        self.categoryId = categoryId;
        self.name = name;
    }
    return self;
}

+ (instancetype)categoryId:(int)categoryId name:(NSString *)name {
    Categories *category = [[Categories alloc] categoryId:categoryId name:name];
    return category;
}

@end
