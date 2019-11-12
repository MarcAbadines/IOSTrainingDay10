//
//  RestaurantDetailsViewController.h
//  APICallsTests
//
//  Created by OPSolutions on 10/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Views/RestaurantDetailsView.h"
#import "../../Restaurant/Models/Foods.h"

NS_ASSUME_NONNULL_BEGIN

@interface RestaurantDetailsViewController : UIViewController

@property (strong, nonatomic) RestaurantDetailsView *restaurantDetailsView;
@property (strong, readwrite) Foods *restaurant;
@property (strong, readwrite) NSMutableArray *food;

@end

NS_ASSUME_NONNULL_END
