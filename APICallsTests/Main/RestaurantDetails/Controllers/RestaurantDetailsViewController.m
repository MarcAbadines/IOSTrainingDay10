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
    [self settingUpMap];
}

- (void)getRestaurantDetails {
    self.restaurantDetailsView.restaurantNameLabel.text = self.restaurant.restaurantName;
    self.restaurantDetailsView.restaurantCuisineLabel.text = self.restaurant.restaurantCuisines;
    self.restaurantDetailsView.restaurantRatingLabel.text = [NSString stringWithFormat:@"%.02f", self.restaurant.restaurantUserRating];
    self.restaurantDetailsView.restaurantAddressLabel.text = self.restaurant.restaurantAddress;
    self.restaurantDetailsView.restaurantTimingLabel.text = self.restaurant.restaurantTiming;
    self.restaurantDetailsView.foodCostLabel.text = [NSString stringWithFormat:@"%.02f", self.restaurant.restaurantAverageCostForTwo];
    NSArray  *data = [self.restaurant.restaurantThumb componentsSeparatedByString:@"?"];
    for(NSString* str in data) {
        if([NSURLConnection canHandleRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]]) {
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: str]];
            self.restaurantDetailsView.restaurantImage.image = [UIImage imageWithData: imageData];
        }
    }
    CLLocationDistance distance = [self distanceBetweenCoordinate:[self getCoordinate] andCoordinate:[self getSecondCoordinate]];
    self.restaurantDetailsView.distanceLabel.text = [NSString stringWithFormat:@"Distance from %@: %.4f km", self.restaurant.restaurantName, distance];
}

- (CLLocationCoordinate2D)getCoordinate {
    CLLocationCoordinate2D newCoordinate;
    newCoordinate.latitude = [_currentLatitude floatValue];
    newCoordinate.longitude = [_currentLongitude floatValue];
    return newCoordinate;
}

- (CLLocationCoordinate2D)getSecondCoordinate {
    CLLocationCoordinate2D newCoordinate;
    newCoordinate.latitude = [self.restaurant.restaurantLatitude floatValue];
    newCoordinate.longitude = [self.restaurant.restaurantLongitude floatValue];
    return newCoordinate;
}

- (CLLocationDistance)distanceBetweenCoordinate:(CLLocationCoordinate2D)originCoordinate andCoordinate:(CLLocationCoordinate2D)destinationCoordinate {
    CLLocation *originLocation = [[CLLocation alloc] initWithLatitude:originCoordinate.latitude longitude:originCoordinate.longitude];
    CLLocation *destinationLocation = [[CLLocation alloc] initWithLatitude:destinationCoordinate.latitude longitude:destinationCoordinate.longitude];
    CLLocationDistance distance = [originLocation distanceFromLocation:destinationLocation];
    
    return distance / 1000;
}

- (void)initLocationServices {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager startUpdatingLocation];
    }
}

- (void)settingUpMap {
    CLLocationCoordinate2D restoLocation;
    restoLocation.latitude = [self.restaurant.restaurantLatitude floatValue];
    restoLocation.longitude = [self.restaurant.restaurantLongitude floatValue];
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = restoLocation;
    marker.title = self.restaurant.restaurantName;
    marker.snippet = self.restaurant.restaurantId;
    marker.map = self.restaurantDetailsView.miniRestaurantMapView;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:restoLocation.latitude longitude:restoLocation.longitude];
    [self centerToLocation:location];
    self.restaurantDetailsView.miniRestaurantMapView.myLocationEnabled = YES;
}

- (void)centerToLocation:(CLLocation *)location {
    GMSCameraPosition *camera = [GMSMutableCameraPosition cameraWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude zoom:15];
    self.restaurantDetailsView.miniRestaurantMapView.camera = camera;
}

@end
