//
//  MapViewController.m
//  APICallsTests
//
//  Created by OPSolutions on 11/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

const float zoom = 15.0f;

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startLocationService];
    [self setupMap];
    // Do any additional setup after loading the view.
}

-(void)startLocationService {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager startUpdatingLocation];
    }
}

-(void)setupMap {
    
    CLLocationCoordinate2D carolinaMallLocation;
    carolinaMallLocation.latitude = 14.2190864;
    carolinaMallLocation.longitude = 121.8449656;
    CLLocation *location = [[CLLocation alloc] initWithLatitude:carolinaMallLocation.latitude longitude:carolinaMallLocation.longitude];
    [self centerToLocation:location];
    
    GMSMarker *marker = [[GMSMarker alloc]init];
    marker.position = carolinaMallLocation;
    marker.title = @"Carollina Mall";
    marker.snippet = @"Snippet";
    marker.map = self.locationView.mapView;
}

-(void)centerToLocation:(CLLocation *) location {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude zoom:zoom];
    self.locationView.mapView.camera = camera;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *loc = [locations lastObject];
    [self centerToLocation:loc];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
