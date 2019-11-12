//
//  ChannelsViewController.h
//  APICallsTests
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../Channels/Views/ChannelsView.h"
#import "../../Channels/Views/Cells/ChannelsTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChannelsViewController : UIViewController

@property (strong,nonatomic) ChannelsView *channelView;
@property (strong, readwrite) NSMutableArray *channels;

@end

NS_ASSUME_NONNULL_END
