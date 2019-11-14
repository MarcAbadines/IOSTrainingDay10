//
//  AppSettings.h
//  APICallsTests
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#ifndef AppSettings_h
#define AppSettings_h

@interface AppSettings:NSObject

//@property (strong, nonatomic) NSString *username;

- (NSString *)getUsername;
-(void)setUsername:(NSString *)username;
+ (instancetype)sharedAppDataSettings;
@end

#endif /* AppSettings_h */
