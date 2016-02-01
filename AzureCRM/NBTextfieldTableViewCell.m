//
//  NBTextfieldTableViewCell.m
//  AzureCRM
//
//  Created by Norm Barnard on 1/31/16.
//  Copyright © 2016 NormBarnard. All rights reserved.
//

#import "NBTextfieldTableViewCell.h"

@interface NBTextfieldTableViewCell() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation NBTextfieldTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self.textField becomeFirstResponder];
}

- (NSString *)title {
    return self.titleLabel.text;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (NSString *)value {
    return self.textField.text;
}

- (void)setValue:(NSString *)value {
    self.textField.text = value;
}

- (NSString *)placeholder {
    return self.textField.placeholder;
}

- (void)setPlaceholder:(NSString *)placeholder {
    self.textField.placeholder = placeholder;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate textFieldCell:self didEndEditingText:textField.text];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *value = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self.delegate textFieldCell:self didEndEditingText:value];
    return YES;
}

@end
