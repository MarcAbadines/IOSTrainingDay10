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
#import "../../Chat/Controllers/ChatViewController.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
#import <FirebaseFirestore/FirebaseFirestore.h>
#import <FirebaseCore/FirebaseCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChannelsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) ChannelsView *channelView;
@property (strong, readonly) NSMutableArray *channels;
@property (strong,nonatomic) FIRUser *currentUser;

@end

NS_ASSUME_NONNULL_END
