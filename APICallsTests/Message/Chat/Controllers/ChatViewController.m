//
//  ChatViewController.m
//  APICallsTests
//
//  Created by OPSolutions on 13/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()
@property FIRFirestore *db;
@property FIRCollectionReference *channelsRef;
@property ChannelsDetails *channel;
@property UIAlertController *alertController;

@end

@implementation ChatViewController

+ (instancetype)initWithChannel:(ChannelsDetails *) channels {
    ChatViewController *instance = [[ChatViewController alloc]initWithNibName:nil bundle:nil];
    instance.channel = channels;
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setUp {
    _db = [ FIRFirestore firestore];
    ChatViewController *chatVc = self;
    [_channelsRef addSnapshotListener:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (error != nil) {
            [chatVc showErrorWith:error.localizedDescription];
        }
        for (FIRDocumentChange *change in [snapshot documentChanges]) {
            [chatVc handleDocumentChange:change];
        }
    }];
}

- (void)handleDocumentChange:(FIRDocumentChange *) change {
    ChannelsDetails *channel = [ChannelsDetails initWithDocument:change.document];
    if (channel == nil) {
        return;
    }
//    switch (change.type) {
//        case FIRDocumentChangeTypeAdded:
//            [self addtoChannelToTable:channel];
//            break;
//        case FIRDocumentChangeTypeModified:
//            [self updateChannelToTable:channel];
//            break;
//        case FIRDocumentChangeTypeRemoved:
//            [self removeChannelToTable:channel];
//            break;
//    }
}

- (void)showErrorWith:(NSString *)message{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Channels"
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                               }];
    [alert addAction:okButton];
    _alertController = alert;
    [self presentViewController:alert animated:YES completion:nil];
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
