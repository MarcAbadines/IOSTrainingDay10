//
//  RestaurantView.h
//  APICallsTests
//
//  Created by OPSolutions on 09/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RestaurantView : UIView
@property (weak, nonatomic) IBOutlet UICollectionView *restaurantCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *restaurantTitle;

@end

NS_ASSUME_NONNULL_END
