//
//  ChannelsDetails.h
//  APICallsTests
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "DatabasePresentation.h"
#import <Foundation/Foundation.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import <FirebaseFirestore/FirebaseFirestore.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChannelsDetails : NSObject <DatabasePresentation>

@property (strong, nonatomic) NSString *channelName;
@property (strong, nonatomic) NSString *channelId;

+ (instancetype)initWith:(NSString *)channelName;
+ (instancetype)initWithDocument:(FIRQueryDocumentSnapshot *) document;
@end

NS_ASSUME_NONNULL_END
