//
//  AMSlidingUpTransitionDelegate.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 10/09/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import "AMSlidingUpTransitionDelegate.h"
#import "AMSlidingUpAnimatedTransitioning.h"

@interface AMSlidingUpTransitionDelegate ()

@property (nonatomic) AMSlidingUpTransitionDelegate *sharedTransitionDelegate;

@end

@implementation AMSlidingUpTransitionDelegate

+ (AMSlidingUpTransitionDelegate *)sharedTransitionDelegate {
    static AMSlidingUpTransitionDelegate *sharedTransitionDelegate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTransitionDelegate = [[AMSlidingUpTransitionDelegate alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedTransitionDelegate;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    AMSlidingUpAnimatedTransitioning *controller = [[AMSlidingUpAnimatedTransitioning alloc] init];
    controller.isPresenting = YES;
    return controller;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    AMSlidingUpAnimatedTransitioning *controller = [[AMSlidingUpAnimatedTransitioning alloc] init];
    controller.isPresenting = NO;
    return controller;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

@end
