//
//  HomeViewController.h
//  APICallsTests
//
//  Created by OPSolutions on 08/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "../Views/HomeView.h"
#import "../Models/Categories.h"
#import "../Views/Cell/HomeTableViewCell.h"
#import "../../Restaurant/Controllers/RestaurantViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) HomeView *homeView;
@property (strong, readwrite) NSMutableArray *categories;
@property (strong, nonatomic) NSString *categoryId;

- (void) getCategories;
@end

NS_ASSUME_NONNULL_END

