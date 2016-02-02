//
//  NBContactsTableViewController.m
//  AzureCRM
//
//  Created by Norm Barnard on 1/31/16.
//  Copyright © 2016 NormBarnard. All rights reserved.
//

#import "NBAzureClient.h"
#import "NBContactsTableViewController.h"
#import "NBContactHistoryTableViewController.h"
#import "NBEditContactTableViewController.h"

@interface NBContactsTableViewController ()

@property (strong, nonatomic) NBAzureClient *azureClient;
@property (strong, nonatomic) NSArray *contacts;

@end

@implementation NBContactsTableViewController


- (instancetype)initWithAzureClient:(NBAzureClient *)azureClient; {
    self = [super init];
    if (!self) {
        return nil;
    }
    _azureClient = azureClient;
    return self;
}

- (NSString *)title {
    return NSLocalizedString(@"Contacts", @"contacts table view nav bar title");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(_beginContactRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(_addButtonTapped:)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.refreshControl beginRefreshing];
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y-self.refreshControl.frame.size.height) animated:YES];
    [self _updateContacts];
}

#pragma mark - button actions 

- (IBAction)_addButtonTapped:(UIBarButtonItem *)sender {
    NBEditContactTableViewController *viewController = [[NBEditContactTableViewController alloc] initWithContactInfo:[NSMutableDictionary dictionary] azureClient:self.azureClient];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navController animated:YES completion:nil];
}

- (IBAction)_beginContactRefresh:(UIRefreshControl *)sender {
    [self _updateContacts];
}

#pragma mark - private api

- (void)_updateContacts {
    
    NBContactsTableViewController * __weak weakSelf = self;
    [self.azureClient readAllFromTable:@"contact" completion:^(NSArray *results, NSError *error) {
        [weakSelf.refreshControl endRefreshing];
        if (!error) {
            weakSelf.contacts = results;
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    NSDictionary *user = self.contacts[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user[@"firstName"], user[@"lastName"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - tableview delegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *user = self.contacts[indexPath.row];
    NBContactHistoryTableViewController *viewController = [[NBContactHistoryTableViewController alloc] initWithContactInfo:user azureClient:self.azureClient];
    [self.navigationController pushViewController:viewController animated:YES];
}



@end
