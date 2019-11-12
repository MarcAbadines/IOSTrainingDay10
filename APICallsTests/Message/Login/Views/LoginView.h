//
//  LoginView.h
//  APICallsTests
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginViewDelegate <NSObject>
- (void)didTapSignIn;
@end

@interface LoginView : UIView

@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (strong) id<LoginViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
