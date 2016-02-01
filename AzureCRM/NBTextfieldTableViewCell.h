//
//  NBTextfieldTableViewCell.h
//  AzureCRM
//
//  Created by Norm Barnard on 1/31/16.
//  Copyright © 2016 NormBarnard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NBTextFieldCellDelegate;

@interface NBTextfieldTableViewCell : UITableViewCell

@property (weak, nonatomic) id<NBTextFieldCellDelegate> delegate;
@property (copy, nonatomic) NSString *valueKeyPath;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *value;
@property (nonatomic) NSString *placeholder;

@end


@protocol NBTextFieldCellDelegate <NSObject>

- (void)textFieldCell:(NBTextfieldTableViewCell *)cell didEndEditingText:(NSString *)textValue;

@end
