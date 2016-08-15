//
//  NSArray+AMAdditions.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 10/09/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import "NSArray+AMAdditions.h"

@implementation NSArray (AMAdditions)

- (id)randomObject {
    NSUInteger myCount = [self count];

    if (myCount)
        return [self objectAtIndex:arc4random_uniform((u_int32_t)myCount)];
    else
        return nil;
}

- (NSString*)jsonStringWithPrettyPrint:(BOOL)prettyPrint {
    NSError *error = nil;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions)(prettyPrint?NSJSONWritingPrettyPrinted:0)
                                                         error:&error];
    
    if (error || !jsonData) {
        return @"[]";
    }

    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
