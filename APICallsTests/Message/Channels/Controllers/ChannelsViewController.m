//
//  ChannelsViewController.m
//  APICallsTests
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "ChannelsViewController.h"
#import "../Models/ChannelsDetails.h"

@interface ChannelsViewController ()
@property  FIRFirestore *channelsDb;
@property FIRCollectionReference *channelsRef;
@property UIAlertController *alertController;

@property NSMutableArray *channels;

@end

@implementation ChannelsViewController
- (IBAction)didTapBackButton:(id)sender {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Exit Page"
                                 message:@"Are you sure you want to leave this page?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [[FIRAuth auth] signOut:nil];
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDestructive
                               handler:^(UIAlertAction * action) {
                               }];
    [alert addAction:yesButton];
    [alert addAction:noButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)didTapAddChannels:(id)sender {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Create Channel"
                                 message:@"Please input channel name"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* saveButton = [UIAlertAction
                               actionWithTitle:@"Save"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [self didTapSave];
                               }];
    UIAlertAction* cancelButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleDestructive
                                   handler:^(UIAlertAction * action) {
                                   }];
    [alert addAction:saveButton];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Please input a channel name here:";
    }];
    [alert addAction:cancelButton];
    _alertController = alert;
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.channelView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.channelView = (ChannelsView*)[[[NSBundle mainBundle] loadNibNamed:@"ChannelsView" owner:self options:nil] objectAtIndex:0];
    _channelsDb = [FIRFirestore firestore];
    _channelsRef = [_channelsDb collectionWithPath:@"channel"];
    self.navigationItem.title = [[AppSettings sharedAppDataSettings] getUsername];
    _channels = [[NSMutableArray alloc]init];
    self.channelView.channelsTableView.delegate = self;
    self.channelView.channelsTableView.dataSource = self;
    [self.channelView.channelsTableView registerNib:[UINib nibWithNibName:@"ChannelsTableViewCell" bundle:nil] forCellReuseIdentifier:@"displayCell"];
    self.channelView.frame = self.view.frame;
    [self.view addSubview:self.channelView];
    [self setUpChannels];
}

- (void) didTapSave {
    UITextField *textField = _alertController.textFields[0];
    NSString *channelText = textField.text;
    if ([channelText isEqualToString:@""]) {
        [self showErrorWith:@"Please input channel name"];
        return;
    }
    ChannelsViewController *vc = self;
    NSString *channelName = textField.text;
    ChannelsDetails *channel = [ChannelsDetails initWith:channelName];
    [_channelsRef addDocumentWithData:[channel channelsDict] completion:^(NSError * error) {
        NSString *alertMessage;
        if (error == nil) {
            alertMessage = @"Successfully Added";
        } else {
            alertMessage = @"Error";
        }
        [vc showErrorWith:alertMessage];
    }];
}

- (void)setUpChannels {
    _channelsDb = [FIRFirestore firestore];
    _channelsRef = [_channelsDb collectionWithPath:@"channel"];
    _channels = [[NSMutableArray alloc]init];
    ChannelsViewController *channelVc = self;
    [_channelsRef addSnapshotListener:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (error != nil) {
            [channelVc showErrorWith:error.localizedDescription];
        }
        for (FIRDocumentChange *change in [snapshot documentChanges]) {
            [channelVc handleDocumentChange:change];
        }
    }];
}

- (void)handleDocumentChange:(FIRDocumentChange *) change {
    ChannelsDetails *channel = [ChannelsDetails initWithDocument:change.document];
    if (channel == nil) {
        return;
    }
    switch (change.type) {
        case FIRDocumentChangeTypeAdded:
            [self addtoChannelToTable:channel];
            break;
        case FIRDocumentChangeTypeModified:
            [self updateChannelToTable:channel];
            break;
        case FIRDocumentChangeTypeRemoved:
            [self removeChannelToTable:channel];
            break;
    }
}

- (void)showErrorWith:(NSString *)message{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Channel Message"
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

- (void)addtoChannelToTable:(ChannelsDetails *)channel {
    if([_channels containsObject:channel]) {
        return;
    }
    [_channels addObject:channel];
    NSInteger index = [_channels count] -1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    NSArray *paths = [NSArray arrayWithObject:indexPath];
    [self.channelView.channelsTableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)removeChannelToTable:(ChannelsDetails *)channel {
    int count = 0;
    for (ChannelsDetails *channelObj in _channels) {
        if ([channelObj.channelName isEqualToString:channel.channelName]){
            [_channels removeObjectAtIndex:count];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:count inSection:0];
            NSArray *paths = [NSArray arrayWithObject:indexPath];
            [self.channelView.channelsTableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        count++;
    }
}

- (void)updateChannelToTable:(ChannelsDetails *)channel {
    NSInteger index = [_channels indexOfObject:channel];
    _channels[index] = channel;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    NSArray *paths = [NSArray arrayWithObject:indexPath];
    [self.channelView.channelsTableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSUInteger)numberOfSectionInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_channels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ChannelsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"displayCell"];
    ChannelsDetails *channel = _channels[indexPath.row];
    cell.channelNameLabel.text = channel.channelName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ChannelsDetails *channel = _channels[indexPath.row];
    if (channel == nil) {
        return;
    }
    ChatViewController *vc = [ChatViewController initWithChannel:channel user:_currentUser];
    if ([self navigationController] != nil) {
        [[self navigationController] showViewController:vc sender:nil];
    } else {
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ChannelsDetails *channel = _channels[indexPath.row];
        [[_channelsRef documentWithPath:channel.channelId] deleteDocument];
    }
}

@end
