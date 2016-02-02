//
//  NBDatePickerTableViewCell.m
//  AzureCRM
//
//  Created by Norm Barnard on 2/1/16.
//  Copyright © 2016 NormBarnard. All rights reserved.
//

#import "NBDatePickerTableViewCell.h"

@interface NBDatePickerTableViewCell()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end


@implementation NBDatePickerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.datePicker addTarget:self action:@selector(_datePickerDidChangeDate:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)setDefaultDate:(NSDate *)defaultDate {
    _defaultDate = defaultDate;
    self.datePicker.date = defaultDate;
}

- (IBAction)_datePickerDidChangeDate:(UIDatePicker *)sender {
    [self.delegate datePickerCell:self didChangeDate:sender.date];
}

@end
