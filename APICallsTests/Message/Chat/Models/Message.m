//
//  Message.m
//  APICallsTests
//
//  Created by OPSolutions on 13/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "Message.h"

@implementation Message

+ (instancetype)initWithDocument:(FIRQueryDocumentSnapshot *)document {
    NSDictionary *data = document.data;
    NSString *senderId = data[@"senderId"];
    NSString *senderName = data[@"sendername"];
    NSDate *date = data[@"date"];
    NSString *text = data[@"text"];
    if (senderId == nil) {
        return nil;
    }
    Message *message = [[Message alloc] initWithSenderId:senderId senderDisplayName:senderName date:date text:text];
    return message;
}

- (NSDictionary *)channelsDict {
    NSDictionary *data;
    data = @{ @"senderId": [self senderId],
              @"senderName": [self senderDisplayName],
              @"date": [self date],
              @"text": [self text]
              };
    return data;
}

@end