//
//  RestaurantViewController.h
//  APICallsTests
//
//  Created by OPSolutions on 09/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Views/RestaurantView.h"
#import <AFNetworking/AFNetworking.h>
#import "../Models/Foods.h"
#import "../Views/Cells/RestaurantCollectionViewCell.h"
#import "../../RestaurantDetails/Controllers/RestaurantDetailsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RestaurantViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) RestaurantView *restaurantView;
@property (strong, readwrite) NSMutableArray *restaurants;
@property (strong, nonatomic) NSString *categoryId;
@property (strong, nonatomic) Foods *restaurant;

@end

NS_ASSUME_NONNULL_END
