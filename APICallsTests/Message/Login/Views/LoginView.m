//
//  LoginView.m
//  APICallsTests
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (IBAction)didTapSignIn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapSignIn)]) {
        [self.delegate didTapSignIn];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
