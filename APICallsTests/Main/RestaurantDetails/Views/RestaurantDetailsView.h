//
//  RestaurantDetailsView.h
//  APICallsTests
//
//  Created by OPSolutions on 10/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

NS_ASSUME_NONNULL_BEGIN

@interface RestaurantDetailsView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantCuisineLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantTimingLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantAddressLabel;
@property (weak, nonatomic) IBOutlet GMSMapView *miniRestaurantMapView;

@end

NS_ASSUME_NONNULL_END
