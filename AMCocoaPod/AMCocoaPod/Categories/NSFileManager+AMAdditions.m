//
//  NSFileManager+AMAdditions.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 23/04/15.
//  Copyright (c) 2015 Adap Mobile ApS. All rights reserved.
//

#import "NSFileManager+AMAdditions.h"

@implementation NSFileManager (AMAdditions)

+ (BOOL)existsPath:(NSString*)path {
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    BOOL isDir;
    
    BOOL exists = [filemgr fileExistsAtPath:path isDirectory:&isDir];
    
    if (exists) {
        return YES;
    }
    
    return NO;
}

@end
