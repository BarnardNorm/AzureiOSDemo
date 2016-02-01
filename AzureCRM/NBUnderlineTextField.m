//
//  NBUnderlineTextField.m
//  AzureCRM
//
//  Created by Norm Barnard on 1/31/16.
//  Copyright © 2016 NormBarnard. All rights reserved.
//

#import "NBUnderlineTextField.h"

@implementation NBUnderlineTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 8.0f, 0.0f);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 8.0f, 0.0f);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 8.0f, 0.0f);
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, self.tintColor.CGColor);
    CGContextSetLineWidth(ctx, 1.0f);
    CGContextMoveToPoint(ctx, 0.0f, CGRectGetMaxY(self.bounds));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds));
    CGContextStrokePath(ctx);
}

@end
