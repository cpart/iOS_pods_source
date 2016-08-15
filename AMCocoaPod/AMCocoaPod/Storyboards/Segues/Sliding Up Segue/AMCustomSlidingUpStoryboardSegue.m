//
//  AMCustomSlidingUpStoryboardSegue.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 10/09/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import "AMCustomSlidingUpStoryboardSegue.h"
#import "AMSlidingUpTransitionDelegate.h"

@implementation AMCustomSlidingUpStoryboardSegue

- (void)perform {
    UIViewController *source = (UIViewController*)self.sourceViewController;
    UIViewController *destination = (UIViewController*)self.destinationViewController;
    
    [destination setModalPresentationStyle:UIModalPresentationCustom];
    [destination setTransitioningDelegate:[AMSlidingUpTransitionDelegate sharedTransitionDelegate]];
    destination.view.backgroundColor = [UIColor clearColor];

    [source presentViewController:self.destinationViewController animated:YES completion:nil];
}

@end
