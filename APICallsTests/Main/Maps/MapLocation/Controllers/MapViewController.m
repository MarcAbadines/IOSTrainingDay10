//
//  MapViewController.m
//  APICallsTests
//
//  Created by OPSolutions on 11/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "MapViewController.h"
#import "../../../Restaurant/Models/Foods.h"
#include <UIKit/UIKit.h>

@interface MapViewController ()

@end

@implementation MapViewController

- (IBAction)tapBackButton:(id)sender {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Message"
                                 message:@"Are you sure you want to leave this page?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                               }];
    [alert addAction:yesButton];
    [alert addAction:noButton];
    [self presentViewController:alert animated:YES completion:nil];
}


const float zoom = 15.0f;

- (void)viewDidLoad {
    [super viewDidLoad];
        self.locationView = (MapView *)[[[NSBundle mainBundle] loadNibNamed:@"MapView" owner:self options:nil] objectAtIndex:0];
    self.locationView.frame = self.view.bounds;
    [self.view addSubview:self.locationView];
    [self createLocationServices];
    [self setupMap];
}

- (void)createLocationServices {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager startUpdatingLocation];
    }
}

- (void)centerToLocation:(CLLocation *)location {
    GMSCameraPosition *camera = [GMSMutableCameraPosition cameraWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude zoom:zoom];
    self.locationView.mapView.camera = camera;
}

- (void)setupMap {
    CLLocationCoordinate2D restaurantLocation;
    int counter = 0;
    for (Foods *restaurant in self.restaurants) {
        CLLocationCoordinate2D restoLocation;
        restoLocation.latitude = [restaurant.restaurantLatitude floatValue];
        restoLocation.longitude = [restaurant.restaurantLongitude floatValue];
        if (counter == 0) {
            restaurantLocation = restoLocation;
            CLLocation *location = [[CLLocation alloc] initWithLatitude:restaurantLocation.latitude longitude:restaurantLocation.longitude];
            [self centerToLocation:location];
        }
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = restoLocation;
        marker.title = restaurant.restaurantName;
        marker.snippet = @"Restaurant";
        marker.map = self.locationView.mapView;
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.tappable = YES;
        counter++;
    }
    self.locationView.mapView.myLocationEnabled = YES;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Error!"
                                 message:@"Invalid Map Credentials!"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okayButton = [UIAlertAction
                                 actionWithTitle:@"Okay"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action) {
                                 }];
    [alert addAction:okayButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"returnDetails"]) {
        UINavigationController *navVc = [segue destinationViewController];
        RestaurantDetailsViewController *restoVc = navVc.viewControllers[0];
        restoVc.food = self.restaurants;
    }
}

- (BOOL) mapView: (GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    [mapView setSelectedMarker:marker];
    
    [self performSegueWithIdentifier:@"returnDetails" sender:nil];
    return YES;
}

@end
