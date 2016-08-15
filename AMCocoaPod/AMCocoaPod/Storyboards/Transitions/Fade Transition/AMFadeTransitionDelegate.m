//
//  AMFadeTransitionDelegate.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 10/09/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import "AMFadeTransitionDelegate.h"
#import "AMFadeAnimatedTransitioning.h"

@interface AMFadeTransitionDelegate ()

@property (nonatomic) AMFadeTransitionDelegate *sharedTransitionDelegate;

@end

@implementation AMFadeTransitionDelegate

+ (AMFadeTransitionDelegate *)sharedTransitionDelegate {
    static AMFadeTransitionDelegate *sharedTransitionDelegate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTransitionDelegate = [[AMFadeTransitionDelegate alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedTransitionDelegate;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    AMFadeAnimatedTransitioning *controller = [[AMFadeAnimatedTransitioning alloc] init];
    controller.isPresenting = YES;
    return controller;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    AMFadeAnimatedTransitioning *controller = [[AMFadeAnimatedTransitioning alloc] init];
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
