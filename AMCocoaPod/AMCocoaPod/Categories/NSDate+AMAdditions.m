//
//  NSDate+AMAdditions.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 05/09/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import "NSDate+AMAdditions.h"

@implementation NSDate (AMAdditions)

+ (NSDate*)timeWithHour:(NSUInteger)hour minute:(NSUInteger)minute {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    comps.hour = hour;
    comps.minute = minute;
    
    NSDate *timeDate = [calendar dateFromComponents:comps];
    
    return timeDate;
}

+ (BOOL)dayOfDate:(NSDate*)firstDate equalsToDate:(NSDate*)secondDate {
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay startDate:&firstDate interval:NULL forDate:firstDate];
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay startDate:&secondDate interval:NULL forDate:secondDate];
    
    if ([secondDate compare:firstDate] == NSOrderedSame) {
        return YES;
    }
    
    return NO;
}

- (BOOL)timeIsBetweenHour:(NSUInteger)firstHour andHour:(NSUInteger)secondHour {
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units fromDate:self];
    
    if (components.hour >= firstHour && components.hour <= 23) {
        return YES;
    }
    
    return NO;
}

+ (NSInteger)minutesBetweenFirstDate:(NSDate*)firstDate secondDate:(NSDate*)secondDate {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:firstDate toDate:secondDate options:0];
    
    return components.minute;
}

- (NSString *)trimDate {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"dd-MM-yyyy";
    
    return [format stringFromDate:self];
}

+ (NSArray*)findDatesFrom:(NSDate*)date numberOfDays:(NSUInteger)numberOfDays option:(AMDatesSearchOption)option {
    NSMutableArray *arrayOfDates = [[NSMutableArray alloc] init];
    
    NSDate *nextDate = date;
    
    for (NSUInteger i = 0; i < numberOfDays; i++) {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:nextDate];
        [components setCalendar:[NSCalendar currentCalendar]];
        
        NSDate *currentDate = [components date];
        
        [arrayOfDates addObject:currentDate];
        
        if (option == AMDatesSearchOptionForward) {
            nextDate = [nextDate dateByAddingNumberOfDays:1];
        } else {
            nextDate = [nextDate dateBySubtractingNumberOfDays:1];
        }
    }
    
    return arrayOfDates;
}

- (NSDate*)dateByAddingNumberOfDays:(NSInteger)days {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)dateBySubtractingNumberOfDays:(NSInteger)days{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:-1*days];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)roundDateToLowerHour {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:
                                    NSCalendarUnitEra |
                                    NSCalendarUnitYear |
                                    NSCalendarUnitMonth |
                                    NSCalendarUnitDay |
                                    NSCalendarUnitHour |
                                    NSCalendarUnitMinute
                                               fromDate:self];
    [components setMinute:0];
    
    return [calendar dateFromComponents:components];
}

- (NSDate*)roundDateToUpperHour {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:
                                    NSCalendarUnitEra |
                                    NSCalendarUnitYear |
                                    NSCalendarUnitMonth |
                                    NSCalendarUnitDay |
                                    NSCalendarUnitHour |
                                    NSCalendarUnitMinute
                                               fromDate:self];
    [components setMinute:0];
    [components setHour:components.hour+1];
    
    return [calendar dateFromComponents:components];
}

- (BOOL)isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate {
    if ([self compare:beginDate] == NSOrderedAscending)
        return NO;
    
    if ([self compare:endDate] == NSOrderedDescending)
        return NO;
    
    return YES;
}

+ (NSDate*)dateWithFormat:(NSString*)format string:(NSString*)string {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    
    return [dateFormat dateFromString:string];
}

- (NSDateComponents*)calculatePeriodBetween:(NSDate*)start and:(NSDate*)finish {
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlags =  NSCalendarUnitYear| NSCalendarUnitMonth;
    NSDateComponents *components = [gregorian components:unitFlags fromDate:start toDate:finish options:0];
    
    return components;
}

+ (NSDate*)dateWithType:(AMDateType)dateType {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps =
    [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                fromDate:[NSDate date]];
    
    if(dateType == AMDateTypeYesterday) {
        comps.day--;
    } else if(dateType == AMDateTypeThisWeek) {
        comps.weekday = 1;
    } else if(dateType == AMDateTypeLastWeek) {
        comps.weekday = 1;
        comps.weekOfMonth--;
    } else if(dateType == AMDateTypeThisMonth) {
        comps.day = 1;
    } else if(dateType == AMDateTypeLastMonth) {
        comps.day = 1;
        comps.month--;
    } else if(dateType == AMDateTypeToday) {
        return [calendar dateFromComponents:comps];
    }
    
    return nil;
}

@end
