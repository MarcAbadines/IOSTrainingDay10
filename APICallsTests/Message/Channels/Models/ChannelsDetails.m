//
//  ChannelsDetails.m
//  APICallsTests
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "ChannelsDetails.h"

@implementation ChannelsDetails

+ (instancetype)initWith:(NSString *)channelName {
    ChannelsDetails *channel = [[ChannelsDetails alloc] init];
    channel.channelName = channelName;
    return channel;
}

+ (instancetype)initWithDocument:(FIRQueryDocumentSnapshot *) document {
    NSDictionary *data = document.data;
    NSString *name = data[@"name"];
    if(name==nil) {
        return nil;
    }
    ChannelsDetails *channel = [ChannelsDetails initWith:name];
    channel.channelId = data[@"id"];
    return channel;
}

- (NSDictionary *)channelsDict {
    NSDictionary *returnVal;
    returnVal = @{ @"name":_channelName };
    return returnVal;
}

@end
