//
//  AMFadeTransitionDelegate.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 10/09/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMFadeTransitionDelegate : NSObject <UIViewControllerTransitioningDelegate>

+ (AMFadeTransitionDelegate*)sharedTransitionDelegate;

@end
