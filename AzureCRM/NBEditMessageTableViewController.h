//
//  NBEditMessageTableViewController.h
//  AzureCRM
//
//  Created by Norm Barnard on 2/1/16.
//  Copyright © 2016 NormBarnard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBEditMessageTableViewController : UITableViewController

- (instancetype)initWithContact:(NSDictionary *)contact azureClient:(NBAzureClient *)azureClient;

@end
