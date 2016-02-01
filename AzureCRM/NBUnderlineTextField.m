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
    return CGRectMake(8.0f, 0.0f, CGRectGetWidth(bounds) - 8.0f, CGRectGetHeight(bounds));
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectMake(8.0f, 0.0f, CGRectGetWidth(bounds) - 8.0f, CGRectGetHeight(bounds));
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
