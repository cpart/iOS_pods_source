//
//  NSDictionary+AMAdditions.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 30/01/15.
//  Copyright (c) 2015 Adap Mobile ApS. All rights reserved.
//

#import "NSDictionary+AMAdditions.h"

@implementation NSDictionary (AMAdditions)

- (id)retrieve:(NSString*)valueName defaultValue:(id)defaultValue {
    if (!valueName) {
        return nil;
    }
    
    id value = self[valueName];
    
    if (!value || value == [NSNull null]) {
        return defaultValue;
    }
    
    return value;
}

- (id)retrieve:(NSString*)valueName {
    return [self retrieve:valueName defaultValue:nil];
}

- (NSString*)jsonStringWithPrettyPrint:(BOOL)prettyPrint {
    NSError *error = nil;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions)(prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (error || !jsonData) {
        return @"{}";
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSString*)encodedURLQueryString {
    NSMutableArray *parts = [NSMutableArray array];
    
    for (id key in self) {
        id value = [self valueForKey: key];
        
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        NSString *encodedValue = @"";
        
        if ([value isKindOfClass:[NSString class]]) {
            encodedValue = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        } else if ([value isKindOfClass:[NSNumber class]]) {
            encodedValue = [[value stringValue] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        } else {
            continue;
        }
        
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject: part];
    }
    
    return [parts componentsJoinedByString: @"&"];
}

@end
