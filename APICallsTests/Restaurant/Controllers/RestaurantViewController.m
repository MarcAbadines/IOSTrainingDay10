//
//  RestaurantViewController.m
//  APICallsTests
//
//  Created by OPSolutions on 09/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "RestaurantViewController.h"

@interface RestaurantViewController ()

@end

@implementation RestaurantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.restaurantView = (RestaurantView *)[[[NSBundle mainBundle] loadNibNamed:@"RestaurantView" owner:self options:nil] objectAtIndex:0];
    self.restaurantView.restaurantCollectionView.delegate = self;
    self.restaurantView.restaurantCollectionView.dataSource = self;
    self.restaurantView.frame = self.view.bounds;
    self.restaurantView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.restaurantView];
    [self.restaurantView.restaurantCollectionView registerNib:[UINib nibWithNibName:@"RestaurantCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"restaurantIdentifier"];
    [self getRestaurants];
}

- (void) getRestaurants {
    NSString *categoriesUrl = @"https://developers.zomato.com/api/v2.1/search";
    NSString *apiKey = @"0ec904c23c17a2c521c1b83169be3680";
    NSDictionary *parameters = @{@"category" : _categoryId,
                                 @"lat" : @"14.219866",
                                 @"lon" : @"121.037037",
                                 @"radius" : @"2000",
                                 @"sort" : @"real_distance"
                                 };
 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:apiKey forHTTPHeaderField:@"user-key"];
    [manager GET:categoriesUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *responseDictionary = responseObject;
        NSArray *responseArray = responseDictionary[@"restaurants"];
        self.restaurants = [[NSMutableArray alloc] init];
        for (id item in responseArray) {
            NSDictionary *responseCategory = item[@"restaurant"];
            Foods *restaurant = [Foods restaurantId:responseCategory[@"id"]];
            NSDictionary *location = responseCategory[@"location"];
            NSDictionary *userRating = responseCategory[@"user_rating"];
            restaurant.restaurantName = responseCategory[@"name"];
            restaurant.restaurantAddress = location[@"address"];
            restaurant.restaurantThumb = responseCategory[@"thumb"];
            restaurant.restaurantUserRating = [userRating[@"aggregate_rating"] floatValue];
            restaurant.restaurantCuisines = responseCategory[@"cuisines"];
            restaurant.restaurantTiming = responseCategory[@"timings"];
            restaurant.restaurantAverageCostForTwo = [responseCategory[@"average_cost_for_two"] floatValue];
            [self.restaurants addObject:restaurant];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.restaurantView.restaurantCollectionView reloadData];
        });
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"restaurantIdentifier" forIndexPath:indexPath];
    Foods *restaurant = self.restaurants[indexPath.row];
    cell.restaurantNameLabel.text = restaurant.restaurantName;
    cell.restaurantAddress.text = restaurant.restaurantAddress;
    NSURL *url = [NSURL URLWithString:restaurant.restaurantThumb];
    NSData * imageData = [NSData dataWithContentsOfURL: url];
    if ([restaurant.restaurantThumb isEqualToString:@""]) {
        UIImage *image = [UIImage imageNamed:@"img_noImage"];
        cell.restaurantImage.image = image;
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            cell.restaurantImage.image = image;
        });
    }
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.restaurants count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Foods *restaurant = self.restaurants[indexPath.item];
    self.restaurant = restaurant;
    [self performSegueWithIdentifier:@"displayRestaurantIdentifier" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"displayRestaurantIdentifier"]) {
        RestaurantDetailsViewController *restaurantDetailsVc = [segue destinationViewController];
        restaurantDetailsVc.restaurant = self.restaurant;
    }
}

@end
