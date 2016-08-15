//
//  NSDate+AMAdditions.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 05/09/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AMDatesSearchOption) {
    AMDatesSearchOptionForward,
    AMDatesSearchOptionBackward
};

typedef NS_ENUM(NSUInteger, AMDateType) {
    AMDateTypeYesterday,
    AMDateTypeThisWeek,
    AMDateTypeLastWeek,
    AMDateTypeThisMonth,
    AMDateTypeLastMonth,
    AMDateTypeToday
};


@interface NSDate (AMAdditions)

+ (NSDate*)timeWithHour:(NSUInteger)hour minute:(NSUInteger)minute;
+ (BOOL)dayOfDate:(NSDate*)firstDate equalsToDate:(NSDate*)secondDate;
- (BOOL)timeIsBetweenHour:(NSUInteger)firstHour andHour:(NSUInteger)secondHour;
+ (NSInteger)minutesBetweenFirstDate:(NSDate*)firstDate secondDate:(NSDate*)secondDate;
- (NSString*)trimDate;
+ (NSArray*)findDatesFrom:(NSDate*)date numberOfDays:(NSUInteger)numberOfDays option:(AMDatesSearchOption)option;
- (NSDate*)dateByAddingNumberOfDays:(NSInteger)days;
- (NSDate*)dateBySubtractingNumberOfDays:(NSInteger)days;
- (NSDate*)roundDateToLowerHour;
- (NSDate*)roundDateToUpperHour;
- (BOOL)isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
+ (NSDate*)dateWithFormat:(NSString*)format string:(NSString*)string;
- (NSDateComponents*)calculatePeriodBetween:(NSDate*)start and:(NSDate*)finish;
+ (NSDate*)dateWithType:(AMDateType)dateType;

@end
