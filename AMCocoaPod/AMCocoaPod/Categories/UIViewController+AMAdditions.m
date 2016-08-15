//
//  UIViewController+AMAdditions.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 11/09/14.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import "UIViewController+AMAdditions.h"
#import <objc/runtime.h>

static const void *OverlayViewKey = &OverlayViewKey;

@implementation UIViewController (AMAdditions)


- (void)setOverlay:(UIView *)overlayView {
    objc_setAssociatedObject(self, OverlayViewKey, overlayView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView*)overlayView {
    return objc_getAssociatedObject(self, OverlayViewKey);
}

- (void)showOverlayWithColor:(UIColor*)color opacity:(CGFloat)opacity animated:(BOOL)animated userInteractionEnabled:(BOOL)userInteractionEnabled {
    CGRect parentBounds = self.view.bounds;

    UIView *overlayViewTemp = [self overlayView];
    
    if (overlayViewTemp == nil) {
        overlayViewTemp = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, parentBounds.size.width, parentBounds.size.height)];
        [self setOverlay:overlayViewTemp];
    }
    
    overlayViewTemp.alpha = 0.0f;
    overlayViewTemp.backgroundColor = color;
    overlayViewTemp.userInteractionEnabled = userInteractionEnabled;

    [self.view addSubview:overlayViewTemp];
    [self.view bringSubviewToFront:overlayViewTemp];
    
    if (animated) {
        [UIView animateWithDuration:0.5f animations:^{
            overlayViewTemp.alpha =  opacity;
        }];
    } else {
        overlayViewTemp.alpha = opacity;
    }
}

- (void)hideOverlay:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.5f animations:^{
            self.overlayView.alpha =  0.0f;
        } completion:^(BOOL finished) {
            [self.overlayView removeFromSuperview];
        }];
    } else {
        [self.overlayView removeFromSuperview];
    }
}

#pragma mark - Navigation

/**
 Present a view controller modally using a storyboard name and a view controller storyboard id.
 The method is similar to presentViewController:animated:completion:.
 Animation prameters should be set from attributes inspector.
 */
- (void)presentViewControllerWithId:(NSString*)identifier fromStoryboard:(NSString*)storyboard animated:(BOOL)animated completion:(void(^)(id))completion{
    UIStoryboard *destinationStoryboard = [UIStoryboard storyboardWithName:storyboard bundle:[NSBundle mainBundle]];
    UIViewController *viewController = [destinationStoryboard instantiateViewControllerWithIdentifier:identifier];
    [self presentViewController:viewController animated:animated completion:^{
        if (completion) {
            completion(viewController);
        }
    }];
}

@end
