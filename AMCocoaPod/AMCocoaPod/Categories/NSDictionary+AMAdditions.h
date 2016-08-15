//
//  NSDictionary+AMAdditions.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 30/01/15.
//  Copyright (c) 2015 Adap Mobile ApS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (AMAdditions)

- (id)retrieve:(NSString*)valueName defaultValue:(id)defaultValue;
- (id)retrieve:(NSString*)valueName;
- (NSString*)jsonStringWithPrettyPrint:(BOOL)prettyPrint;
- (NSString*)encodedURLQueryString;

@end
