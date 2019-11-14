//
//  RestaurantDetailsViewController.m
//  APICallsTests
//
//  Created by OPSolutions on 10/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "RestaurantDetailsViewController.h"

@interface RestaurantDetailsViewController ()

@end

@implementation RestaurantDetailsViewController
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.restaurantDetailsView = (RestaurantDetailsView *)[[[NSBundle mainBundle] loadNibNamed:@"RestaurantDetailsView" owner:self options:nil] objectAtIndex:0];
    self.restaurantDetailsView.frame = self.view.bounds;
    self.restaurantDetailsView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.restaurantDetailsView];
    self.navigationItem.title = @"Restaurant";
    [self getRestaurantDetails];
}

- (void)getRestaurantDetails {
    self.restaurantDetailsView.restaurantNameLabel.text = self.restaurant.restaurantName;
    self.restaurantDetailsView.restaurantCuisineLabel.text = self.restaurant.restaurantCuisines;
    self.restaurantDetailsView.restaurantRatingLabel.text = [NSString stringWithFormat:@"%.02f", self.restaurant.restaurantUserRating];
    self.restaurantDetailsView.restaurantAddressLabel.text = self.restaurant.restaurantAddress;
    self.restaurantDetailsView.restaurantTimingLabel.text = self.restaurant.restaurantTiming;
    self.restaurantDetailsView.foodCostLabel.text = [NSString stringWithFormat:@"%.02f", self.restaurant.restaurantAverageCostForTwo];
    NSLog(@"%@",self.restaurant.restaurantReviews);
    NSArray  *data = [self.restaurant.restaurantThumb componentsSeparatedByString:@"?"];
    for(NSString* str in data) {
        if([NSURLConnection canHandleRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]]) {
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: str]];
            self.restaurantDetailsView.restaurantImage.image = [UIImage imageWithData: imageData];
        }
    }
}

@end
