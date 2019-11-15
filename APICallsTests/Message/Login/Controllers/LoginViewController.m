//
//  LoginViewController.m
//  APICallsTests
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.loginView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.loginView = (LoginView*)[[[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:self options:nil] objectAtIndex:0];
    self.loginView.frame = self.view.frame;
    self.loginView.delegate = self;
    [self.view addSubview:self.loginView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToChannels"]) {
        UINavigationController *navVc = [segue destinationViewController];
        ChannelsViewController *channelsVc = navVc.viewControllers[0];
        FIRUser *user = sender;
        channelsVc.currentUser = user;
    }
}

- (void) didTapSignIn {
    NSString *usernameText = self.loginView.usernameText.text;
    if ([usernameText isEqualToString:@""]) {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Login"
                                     message:@"Please input guest name"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                   }];
        [alert addAction:okButton];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [[AppSettings sharedAppDataSettings] setUsername:usernameText];
        [[FIRAuth auth] signInAnonymouslyWithCompletion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            if (error != nil) {
                NSLog(@"Error signing in");
                return;
            }
            [self performSegueWithIdentifier:@"goToChannels" sender:[authResult user]];
        }];
    }
    self.loginView.usernameText.text = nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
