//
//  LogManager.m
//  LO-Plus
//
//  Created by Raúl Pérez on 15/09/14.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import "LogManager.h"

@implementation LogManager

- (id)init {
    self = [super init];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

+ (LogManager*)sharedManager {
    static LogManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[LogManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedManager;
}

- (void)setup {
    //Do something here...
}

+ (void)logToFile:(NSString*)log {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:@"app.log"];
    
    //create file if it doesn't exist
    if(![[NSFileManager defaultManager] fileExistsAtPath:fileName])
        [[NSFileManager defaultManager] createFileAtPath:fileName contents:nil attributes:nil];
    
    //append text to file (you'll probably want to add a newline every write)
    NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:fileName];
    [file seekToEndOfFile];
    [file writeData:[[NSString stringWithFormat:@"%@ - %@\n", [NSDate date], log] dataUsingEncoding:NSUTF8StringEncoding]];
    [file closeFile];
}

@end
