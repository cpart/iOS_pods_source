//
//  NSFileManager+AMAdditions.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 23/04/15.
//  Copyright (c) 2015 Adap Mobile ApS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (AMAdditions)

+ (BOOL)existsPath:(NSString*)path;

@end
