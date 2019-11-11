//
//  HomeViewController.m
//  APICallsTests
//
//  Created by OPSolutions on 08/11/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "HomeViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.homeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.homeView = (HomeView*)[[[NSBundle mainBundle] loadNibNamed:@"HomeView" owner:self options:nil] objectAtIndex:0];
    self.homeView.frame = self.view.frame;
    [self.view addSubview:self.homeView];
    [self getCategories];
    
    self.homeView.homeTableView.dataSource = self;
    self.homeView.homeTableView.delegate = self;
    [self.homeView.homeTableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"displayCell"];
}

- (void) getCategories {
    NSString *categoriesUrl = @"https://developers.zomato.com/api/v2.1/categories";
    NSString *apiKey = @"0ec904c23c17a2c521c1b83169be3680";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:apiKey forHTTPHeaderField:@"user-key"];
    [manager GET:categoriesUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject){ NSLog(@"JSON %@", responseObject);
        NSDictionary *responseDict = responseObject;
        NSArray *responseArray = responseDict[@"categories"];
        self.categories = [[NSMutableArray alloc] init];
        for (id item in responseArray) {
            NSDictionary *responseCatergoryEnvelop = item[@"categories"];
            Categories *category = [[Categories alloc] categoryId:[responseCatergoryEnvelop[@"id"] intValue] name:responseCatergoryEnvelop[@"name"]];
            [self.categories addObject:category];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.homeView.homeTableView reloadData];
        });
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"displayCell"];
    Categories *catergory = self.categories[indexPath.row];
    cell.nameLabel.text = catergory.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Categories *category = self.categories[indexPath.row];
    _categoryId = [NSString stringWithFormat:@"%i", category.categoryId];
    [self performSegueWithIdentifier:@"restaurantSegue" sender:nil];
    [self.homeView.homeTableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"restaurantSegue"]) {
        RestaurantViewController *restaurantsVc = [segue destinationViewController];
        restaurantsVc.categoryId = self.categoryId;
    }
}

@end
