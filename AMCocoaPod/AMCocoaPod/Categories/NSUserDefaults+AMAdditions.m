//
//  NSUserDefaults+AMAdditions.m
//  Messenger
//
//  Created by Ayoub Khayati on 28/05/15.
//  Copyright (c) 2015 Ayoub Khayati. All rights reserved.
//

#import "NSUserDefaults+AMAdditions.h"

@implementation NSUserDefaults (AMAdditions)

static NSString * const kBooleanKey = @"kBooleanKey";
static NSString * const kIntegerKey = @"kIntegerKey";
static NSString * const kObjectKey  = @"kObjectKey";


+ (void)saveBooleanValue:(BOOL)boolean{
    [[NSUserDefaults standardUserDefaults] setBool:boolean forKey:kBooleanKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)booleanValue{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kBooleanKey];
}

+ (void)saveIntegerValue:(NSInteger)integer{
    [[NSUserDefaults standardUserDefaults] setInteger:integer forKey:kIntegerKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger)integerValue{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIntegerKey];
}

+ (void)saveObject:(id)string{
    [[NSUserDefaults standardUserDefaults] setValue:string forKey:kObjectKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)objectValue{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kObjectKey];
}

@end
