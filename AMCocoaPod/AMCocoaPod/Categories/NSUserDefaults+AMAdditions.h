//
//  NSUserDefaults+AMAdditions.h
//  Messenger
//
//  Created by Ayoub Khayati on 28/05/15.
//  Copyright (c) 2015 Ayoub Khayati. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (AMAdditions)

+ (void)saveBooleanValue:(BOOL)boolean;
+ (BOOL)booleanValue;

+ (void)saveIntegerValue:(NSInteger)integer;
+ (NSInteger)integerValue;

+ (void)saveObject:(id)value;
+ (id)objectValue;

@end
