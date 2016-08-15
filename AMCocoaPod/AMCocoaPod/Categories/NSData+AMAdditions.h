//
//  NSData+AMAdditions.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 08/10/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AMAdditions)

+ (NSString *)encodeToBase64:(NSData*)data;

@end
