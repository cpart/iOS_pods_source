//
//  LogManager.h
//  LO-Plus
//
//  Created by Raúl Pérez on 15/09/14.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogManager : NSObject

+ (instancetype)sharedManager;

+ (void)logToFile:(NSString*)log;

@end
