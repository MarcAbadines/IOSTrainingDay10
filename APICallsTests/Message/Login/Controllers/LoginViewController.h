//
//  LoginViewController.h
//  APICallsTests
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Views/LoginView.h"
#import "../../Channels/Controllers/ChannelsViewController.h"
#import <FirebaseAuth/FirebaseAuth.h>
#import "../../../Utilities/AppSettings.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController <LoginViewDelegate>


@property (strong,nonatomic) LoginView *loginView;
@property (strong) id<LoginViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
