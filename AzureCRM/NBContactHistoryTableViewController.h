//
//  NBContactHistoryTableViewController.h
//  AzureCRM
//
//  Created by Norm Barnard on 2/1/16.
//  Copyright © 2016 NormBarnard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBContactHistoryTableViewController : UITableViewController

- (instancetype)initWithContactInfo:(NSDictionary *)contactInfo azureClient:(NBAzureClient *)azureClient;

@end
