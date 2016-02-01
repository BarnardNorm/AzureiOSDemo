//
//  EditContactTableViewController.m
//  AzureCRM
//
//  Created by Norm Barnard on 1/31/16.
//  Copyright © 2016 NormBarnard. All rights reserved.
//

#import "NBAzureClient.h"
#import "NBEditContactTableViewController.h"
#import "NBTextfieldTableViewCell.h"

@interface NBEditContactTableViewController () <NBTextFieldCellDelegate>

@property (strong, nonatomic) NBAzureClient *azureClient;
@property (strong, nonatomic) NSMutableDictionary *contactInfo;

@end

@implementation NBEditContactTableViewController

- (instancetype)initWithContactInfo:(NSMutableDictionary *)contactInfo azureClient:(NBAzureClient *)azureClient; {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.contactInfo = contactInfo;
    _azureClient = azureClient;
    return self;
}

- (NSString *)title {
    return NSLocalizedString(@"Add Contact", @"add contact navi title");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0f;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NBTextfieldTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NBTextfieldTableViewCell class])];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(_saveButtonTapped:)];
}


#pragma mark - button actions 

- (IBAction)_saveButtonTapped:(id)sender {
    [self.view endEditing:YES];
    NBEditContactTableViewController * __weak weakSelf = self;
    [self.azureClient saveContactInfo:self.contactInfo withCompletion:^(NSDictionary *contact, NSError *error) {
        NSAssert(error == nil, @"%@", error);
        [weakSelf.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NBTextfieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NBTextfieldTableViewCell class]) forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.title = @"First Name";
            cell.valueKeyPath = @"firstName";
            cell.value = self.contactInfo[@"firstName"];
        } else {
            cell.title = @"Last Name";
            cell.valueKeyPath = @"lastName";
            cell.value = self.contactInfo[@"lastName"];
        }
    } else {
        if (indexPath.row == 0) {
            cell.title = @"Title";
            cell.valueKeyPath = @"title";
            cell.value = self.contactInfo[@"title"];
        } else {
            cell.title = @"Company";
            cell.valueKeyPath = @"company";
            cell.value = self.contactInfo[@"company"];
        }
    }
    cell.delegate = self;
    return cell;
}

#pragma mark - textfield delegate 

- (void)textFieldCell:(NBTextfieldTableViewCell *)cell didEndEditingText:(NSString *)textValue {
    self.contactInfo[cell.valueKeyPath] = textValue;
}

@end
