//
//  AMTextField.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 23/09/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import "AMTextField.h"

@implementation AMTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + 10, bounds.origin.y + 8,
                      bounds.size.width - 20, bounds.size.height - 16);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
