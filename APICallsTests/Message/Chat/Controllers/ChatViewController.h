//
//  ChatViewController.h
//  APICallsTests
//
//  Created by OPSolutions on 13/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FirebaseFirestore/FirebaseFirestore.h>
#import <FirebaseCore/FirebaseCore.h>
#import "../../Channels/Models/ChannelsDetails.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatViewController : UIViewController

+ (instancetype)initWithChannel:(ChannelsDetails *) channels;

@end

NS_ASSUME_NONNULL_END
