//
//  Message.h
//  APICallsTests
//
//  Created by OPSolutions on 13/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../../Channels/Models/DatabasePresentation.h"
#import <JSQMessage.h>

NS_ASSUME_NONNULL_BEGIN

@interface Message : JSQMessage <DatabasePresentation>


@end

NS_ASSUME_NONNULL_END
