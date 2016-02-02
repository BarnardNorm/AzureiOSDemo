//
//  NBDatePickerTableViewCell.h
//  AzureCRM
//
//  Created by Norm Barnard on 2/1/16.
//  Copyright © 2016 NormBarnard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NBDatePickerTableViewCellDelegate;

@interface NBDatePickerTableViewCell : UITableViewCell

@property (nonatomic) NSDate *defaultDate;
@property (weak, nonatomic) id<NBDatePickerTableViewCellDelegate> delegate;

@end

@protocol NBDatePickerTableViewCellDelegate <NSObject>

- (void)datePickerCell:(NBDatePickerTableViewCell *)cell didChangeDate:(NSDate *)date;

@end
