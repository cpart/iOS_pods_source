//
//  NSNumber+AMAdditions.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 02/06/15.
//  Copyright (c) 2015 Adap Mobile ApS. All rights reserved.
//

#import "NSNumber+AMAdditions.h"

@implementation NSNumber (AMAdditions)

- (NSDate*)date {
    return [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
}

@end
