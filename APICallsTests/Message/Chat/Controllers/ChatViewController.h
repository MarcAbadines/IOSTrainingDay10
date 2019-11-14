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
#import <FirebaseAuth/FirebaseAuth.h>
#import "../../Channels/Models/ChannelsDetails.h"
#import <JSQMessagesViewController/JSQMessagesViewController.h>
#import <JSQMessagesAvatarImageFactory.h>
#import <JSQMessagesBubbleImageFactory.h>
#import "Message.h"
#import "../../../Utilities/AppSettings.h"
#import <JSQMessagesComposerTextView.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatViewController : JSQMessagesViewController <JSQMessagesInputToolbarDelegate, JSQMessagesCollectionViewDataSource, JSQMessageBubbleImageDataSource, JSQMessageAvatarImageDataSource>

+ (instancetype)initWithChannel:(ChannelsDetails *) channel user:(FIRUser *) user ;

@end

NS_ASSUME_NONNULL_END
