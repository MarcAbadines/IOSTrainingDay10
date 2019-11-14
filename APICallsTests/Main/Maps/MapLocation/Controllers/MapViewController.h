//
//  MapViewController.h
//  APICallsTests
//
//  Created by OPSolutions on 11/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "../Views/MapView.h"
#import "../../../Home/Controllers/HomeViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController<CLLocationManagerDelegate, GMSMapViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) MapView *locationView;
@property (strong, readwrite) NSMutableArray *restaurants;
@property (strong, nonatomic) Foods *restaurant;

@end

NS_ASSUME_NONNULL_END
