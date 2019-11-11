//
//  MapView.h
//  APICallsTests
//
//  Created by OPSolutions on 11/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapView : UIView
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;


@end

NS_ASSUME_NONNULL_END
