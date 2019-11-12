//
//  ChannelsViewController.m
//  APICallsTests
//
//  Created by OPSolutions on 12/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "ChannelsViewController.h"

@interface ChannelsViewController ()

@end

@implementation ChannelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.channelView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.channelView = (ChannelsView*)[[[NSBundle mainBundle] loadNibNamed:@"ChannelsView" owner:self options:nil] objectAtIndex:0];
    self.channelView.frame = self.view.frame;
    [self.view addSubview:self.channelView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.channels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ChannelsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"displayCell"];
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    Categories *category = self.categories[indexPath.row];
//    _categoryId = [NSString stringWithFormat:@"%i", category.categoryId];
//    [self performSegueWithIdentifier:@"restaurantSegue" sender:nil];
//    [self.homeView.homeTableView deselectRowAtIndexPath:indexPath animated:true];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
