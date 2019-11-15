//
//  ChatViewController.m
//  APICallsTests
//
//  Created by OPSolutions on 13/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()
@property FIRFirestore *chatDb;
@property FIRCollectionReference *chatRef;
@property ChannelsDetails *channel;
@property NSMutableArray <Message *> *messages;
@property UIAlertController *alertController;
@property FIRUser *user;

@end

@implementation ChatViewController

+ (instancetype)initWithChannel:(ChannelsDetails *) channel user:(FIRUser *) user {
    ChatViewController *instance = [[ChatViewController alloc]initWithNibName:nil bundle:nil];
    instance.channel = channel;
    instance.user = user;
    instance.messages = [[NSMutableArray alloc]init];
    return instance;
}

- (void)viewDidLoad {
    self.navigationItem.title = _channel.channelName;
    [super viewDidLoad];
    [self setUpInterface];
    [self setUp];
}

- (void)setUpInterface {
    self.inputToolbar.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

- (void)setUp {
    _chatDb = [ FIRFirestore firestore];
    NSString *stringUrl = [NSString stringWithFormat:@"channel/%@/thread", _channel.channelId];
    _chatRef = [_chatDb collectionWithPath:stringUrl];
    ChatViewController *chatVc = self;
    [_chatRef addSnapshotListener:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (error != nil) {
            [chatVc showErrorWith:error.localizedDescription];
        }
        
        for (FIRDocumentChange *change in [snapshot documentChanges]) {
            [chatVc handleDocumentChange:change];
        }
    }];
    self.inputToolbar.contentView.leftBarButtonItem = nil;
}

- (void)handleDocumentChange:(FIRDocumentChange *) change {
    
    Message *msg = [Message initWithDocument:change.document];
    
    if (msg == nil) {
        return;
    }
    switch (change.type) {
        case FIRDocumentChangeTypeAdded:
            [_messages addObject:msg];
            [self.collectionView reloadData];
            [self scrollToBottomAnimated:YES];
            [self setShowTypingIndicator:YES];
            break;

        case FIRDocumentChangeTypeModified:
            break;
        case FIRDocumentChangeTypeRemoved:
            break;
    }
}

- (void)onTapCancel:(UIBarButtonItem *)item{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)showErrorWith:(NSString *)message{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Chat Message"
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


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_messages count];
}



- (id <JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _messages[indexPath.row];
}

- (id <JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessagesAvatarImageFactory *factory = [[JSQMessagesAvatarImageFactory alloc] init];
    Message *msg = _messages[indexPath.row];
    NSString *initial = @"👤";
    if (![msg.senderDisplayName isEqualToString:@""]) {
        initial = [[msg.senderDisplayName substringToIndex:1] capitalizedString];
    }
    return [factory avatarImageWithUserInitials:initial backgroundColor:UIColor.lightGrayColor textColor:UIColor.lightTextColor font:[UIFont systemFontOfSize:14.f]];
}

- (id <JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessagesBubbleImageFactory *factory =[[JSQMessagesBubbleImageFactory alloc] init];
    Message *msg = _messages[indexPath.row];
    if ([self.senderId isEqualToString:msg.senderId]) {
        return [factory outgoingMessagesBubbleImageWithColor:UIColor.blueColor];
    }
    return [factory incomingMessagesBubbleImageWithColor:UIColor.greenColor];
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    return 15.0f;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout  heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath {
    return 15.0f;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    Message *msg = _messages[indexPath.row];
    NSString *nameFormatted = msg.senderDisplayName;
    return [[NSMutableAttributedString alloc] initWithString:nameFormatted];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    Message *msg = self.messages[indexPath.row];
    NSString *dateSent = [formatter stringFromDate:msg.channelsDict[@"date"]];
    return [[NSMutableAttributedString alloc] initWithString:dateSent];
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapMessageBubbleAtIndexPath:(nonnull NSIndexPath *)indexPath {
}

- (NSString *)senderId {
    return _user.uid;
}

- (NSString *)senderDisplayName {
    return [AppSettings.sharedAppDataSettings getUsername];
}

- (void)didPressSendButton:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date {
    Message *msg = [Message messageWithSenderId:senderId displayName:senderDisplayName text:text];
    [self sendMessage:msg];
    self.inputToolbar.contentView.textView.text = nil;
}

- (void)sendMessage:(Message *) message {
    [_chatRef addDocumentWithData:message.channelsDict completion:^(NSError * _Nullable error) {
        ChatViewController *vc = [[ChatViewController alloc] init];
        if (error != nil) {
            [vc showErrorWith:@"Error"];
        }
    }];
}

- (void)didPressAccessoryButton:(UIButton *)sender {
    
}

@end
