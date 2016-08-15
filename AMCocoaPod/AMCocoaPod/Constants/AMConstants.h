//
//  AMConstants.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 05/09/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

// Time

#define SECOND 1
#define MINUTE 60 * SECOND
#define HOUR 60 * MINUTE
#define DAY 24 * HOUR
#define MONTH 30 * DAY

// Numbers checks
#define AMNotFound NSUIntegerMax

// Dates
typedef NS_ENUM(NSUInteger, AMDaysOfTheWeek) {
    AMSunday = 1,
    AMMonday = 2,
    AMTuesday = 3,
    AMWednesday = 4,
    AMThursday = 5,
    AMFriday = 6,
    AMSaturday = 7
};
