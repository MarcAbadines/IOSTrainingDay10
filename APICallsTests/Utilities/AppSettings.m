//
//  AppSettings.m
//  APICallsTests
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppSettings.h"

@implementation AppSettings

- (NSString *)getUsername {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _username = [defaults objectForKey:@"username"];
    return _username;
}

- (void)setUsername:(NSString *)username {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [_username setValue:defaults forKey:@"username"];
}

+ (instancetype)sharedAppDataSettings {
    static AppSettings *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
