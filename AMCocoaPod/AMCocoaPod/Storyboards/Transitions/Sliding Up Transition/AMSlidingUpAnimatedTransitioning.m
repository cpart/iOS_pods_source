//
//  AMSlidingUpAnimatedTransitioning.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 10/24/13.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import "AMSlidingUpAnimatedTransitioning.h"

@implementation AMSlidingUpAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.isPresenting) {
        UIView *inView = [transitionContext containerView];
        UIViewController *destination = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController *origin = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        [inView addSubview:destination.view];
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        [destination.view setFrame:CGRectMake(0, screenRect.size.height, origin.view.frame.size.width, origin.view.frame.size.height)];
        
        [UIView animateWithDuration:0.25f animations:^{
            [destination.view setFrame:CGRectMake(0, 0, origin.view.frame.size.width, origin.view.frame.size.height)];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        UIView *inView = [transitionContext containerView];
        UIViewController *destination = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *origin = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        [inView addSubview:destination.view];
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        [origin.view setFrame:CGRectMake(0, 0, origin.view.frame.size.width, origin.view.frame.size.height)];
        
        [UIView animateWithDuration:0.25f animations:^{
            [destination.view setFrame:CGRectMake(0, screenRect.size.height, origin.view.frame.size.width, origin.view.frame.size.height)];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}


@end
