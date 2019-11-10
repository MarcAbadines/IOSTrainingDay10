//
//  RestaurantCollectionViewCell.h
//  APICallsTests
//
//  Created by OPSolutions on 09/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RestaurantCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantAddress;


@end

NS_ASSUME_NONNULL_END
