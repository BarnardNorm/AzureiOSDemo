//
//  NBEditMessageTableViewController.m
//  AzureCRM
//
//  Created by Norm Barnard on 2/1/16.
//  Copyright © 2016 NormBarnard. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

#import "NBAzureClient.h"
#import "NBDatePickerTableViewCell.h"
#import "NBEditMessageTableViewController.h"
#import "NBTextfieldTableViewCell.h"

@interface NBEditMessageTableViewController () <NBTextFieldCellDelegate, NBDatePickerTableViewCellDelegate>

@property (strong, nonatomic) NSDictionary *contactInfo;
@property (strong, nonatomic) NBAzureClient *azureClient;
@property (strong, nonatomic) NSMutableDictionary *message;

@end

@implementation NBEditMessageTableViewController


- (instancetype)initWithContact:(NSDictionary *)contact azureClient:(NBAzureClient *)azureClient; {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) {
        return nil;
    }
    _azureClient = azureClient;
    _contactInfo = contact;
    _message = [NSMutableDictionary dictionary];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 65.0f;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NBTextfieldTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NBTextfieldTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NBDatePickerTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NBDatePickerTableViewCell class])];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(_saveButtonTapped:)];
    
}

#pragma mark - button actions

- (IBAction)_saveButtonTapped:(UIBarButtonItem *)sender {
    [SVProgressHUD showWithStatus:@"Saving..."];
    [self.azureClient saveMessage:self.message forContact:self.contactInfo completion:^(NSDictionary *message, NSError *error) {
        NSAssert(error == nil, @"%@", error);
        [SVProgressHUD dismiss];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark - cell delegate methods

- (void)textFieldCell:(NBTextfieldTableViewCell *)cell didEndEditingText:(NSString *)textValue {
    self.message[cell.valueKeyPath] = textValue;
}

- (void)datePickerCell:(NBDatePickerTableViewCell *)cell didChangeDate:(NSDate *)date {
    self.message[@"contactDate"] = date;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 2) {
        NBTextfieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NBTextfieldTableViewCell class]) forIndexPath:indexPath];
        cell.title = (indexPath.section == 0) ? @"Method" : @"Address";
        NSString *key = (indexPath.section == 0) ? @"contactMethod" : @"contactAddress";
        cell.value = self.message[key];
        cell.valueKeyPath  = key;
        cell.delegate = self;
        return cell;
    }
    NBDatePickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NBDatePickerTableViewCell class]) forIndexPath:indexPath];
    cell.defaultDate = [NSDate date];
    cell.delegate = self;
    return cell;
}

@end
