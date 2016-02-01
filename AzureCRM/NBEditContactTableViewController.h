//
//  EditContactTableViewController.h
//  AzureCRM
//
//  Created by Norm Barnard on 1/31/16.
//  Copyright © 2016 NormBarnard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NBAzureClient;

@interface NBEditContactTableViewController : UITableViewController

- (instancetype)initWithContactInfo:(NSDictionary *)contactInfo azureClient:(NBAzureClient *)azureClient;

@end
