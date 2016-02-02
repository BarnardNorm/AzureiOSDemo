//
//  NBContactHistoryTableViewController.m
//  AzureCRM
//
//  Created by Norm Barnard on 2/1/16.
//  Copyright © 2016 NormBarnard. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

#import "NBAzureClient.h"
#import "NBContactHistoryTableViewController.h"
#import "NBEditMessageTableViewController.h"
#import "NBRightDetailTableViewCell.h"

@interface NBContactHistoryTableViewController ()

@property (strong, nonatomic) NBAzureClient *azureClient;
@property (strong, nonatomic) NSDictionary *contactInfo;
@property (strong, nonatomic) NSArray *messageHistory;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation NBContactHistoryTableViewController


- (instancetype)initWithContactInfo:(NSDictionary *)contactInfo azureClient:(NBAzureClient *)azureClient; {
    self = [super init];
    if (!self) {
        return nil;
    }
    _azureClient = azureClient;
    _contactInfo = contactInfo;
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NBRightDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NBRightDetailTableViewCell class])];
    self.title = [NSString stringWithFormat:@"%@ %@", self.contactInfo[@"firstName"], self.contactInfo[@"lastName"]];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(_refreshControlShouldUpdate:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(_addButtonTapped:)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.refreshControl beginRefreshing];
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y-self.refreshControl.frame.size.height) animated:YES];
    [self _updateHistory];
}

#pragma mark - button actions

- (IBAction)_addButtonTapped:(UIBarButtonItem *)sender {
    NBEditMessageTableViewController *viewController = [[NBEditMessageTableViewController alloc] initWithContact:self.contactInfo azureClient:self.azureClient];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navController animated:YES completion:nil];
}

- (IBAction)_refreshControlShouldUpdate:(UIRefreshControl *)sender {
    [self _updateHistory];
}

#pragma mark - private api

- (void)_updateHistory {
    NBContactHistoryTableViewController * __weak weakSelf = self;
    [self.azureClient queryHistoryForContact:self.contactInfo completion:^(NSArray *results, NSError *error) {
        [weakSelf.refreshControl endRefreshing];
        NSAssert(error == nil, @"%@", error);
        weakSelf.messageHistory = results;
        [weakSelf.tableView reloadData];
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NBRightDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NBRightDetailTableViewCell class]) forIndexPath:indexPath];
    NSDictionary *message = self.messageHistory[indexPath.row];
    NSDate *date = message[@"contactDate"];
    cell.textLabel.text = [self.dateFormatter stringFromDate:date];
    cell.detailTextLabel.text = message[@"contactMethod"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


@end
