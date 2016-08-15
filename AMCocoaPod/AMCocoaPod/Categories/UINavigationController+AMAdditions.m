//
//  UINavigationController+AMAdditions.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 11/09/14.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import "UINavigationController+AMAdditions.h"
#import <objc/runtime.h>

static const void *OverlayViewKey = &OverlayViewKey;
static const void *OverlayTappedBlockKey = &OverlayTappedBlockKey;

@implementation UINavigationController (AMAdditions)

- (void)setOverlay:(UIView *)overlayView {
    objc_setAssociatedObject(self, OverlayViewKey, overlayView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView*)overlayView {
    return objc_getAssociatedObject(self, OverlayViewKey);
}

- (void)setOverlayTappedBlock:(overlayTappedBlock)overlayTappedBlock {
    objc_setAssociatedObject(self, OverlayTappedBlockKey, overlayTappedBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (overlayTappedBlock)overlayTappedBlock {
    return objc_getAssociatedObject(self, OverlayTappedBlockKey);
}

- (void)showOverlayWithColor:(UIColor*)color opacity:(CGFloat)opacity animated:(BOOL)animated userInteractionEnabled:(BOOL)userInteractionEnabled {
    
    [self showOverlayWithColor:color opacity:opacity animated:animated userInteractionEnabled:userInteractionEnabled blurred:NO];
}

- (void)showOverlayWithColor:(UIColor*)color opacity:(CGFloat)opacity animated:(BOOL)animated userInteractionEnabled:(BOOL)userInteractionEnabled blurred:(BOOL)blurred {
    CGRect parentBounds = self.view.bounds;
    
    UIView *overlayViewTemp = [self overlayView];
    
    if (overlayViewTemp == nil) {
        if (blurred) {
            UIVisualEffect *blurEffect;
            blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            overlayViewTemp = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            overlayViewTemp.frame = CGRectMake(0.0f, 0.0f, parentBounds.size.width, parentBounds.size.height);
        } else {
            overlayViewTemp = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, parentBounds.size.width, parentBounds.size.height)];
        }
        
        [self setOverlay:overlayViewTemp];
    }

    overlayViewTemp.alpha = 0.0f;
    overlayViewTemp.backgroundColor = color;
    overlayViewTemp.userInteractionEnabled = userInteractionEnabled;
    
    [self.view addSubview:overlayViewTemp];
    [self.view bringSubviewToFront:overlayViewTemp];
    
    if (animated) {
        [UIView animateWithDuration:0.20f animations:^{
            overlayViewTemp.alpha =  opacity;
        }];
    } else {
        overlayViewTemp.alpha = opacity;
    }
}

- (void)hideOverlay:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.1f animations:^{
            self.overlayView.alpha =  0.0f;
        } completion:^(BOOL finished) {
            [self.overlayView removeFromSuperview];
        }];
    } else {
        [self.overlayView removeFromSuperview];
    }
}

- (void)addTapGestureRecognizerToOverlay:(overlayTappedBlock)block {
    if (self.overlayView) {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(invokeOverlayTappedAction:)];
        self.overlayTappedBlock = block;
        [self.overlayView addGestureRecognizer:tapGestureRecognizer];
    }
}

- (void)passPanGestureRecognizer:(UIPanGestureRecognizer*)panGesture {
    if (self.overlayView) {
        [self.overlayView addGestureRecognizer:panGesture];
    }
}

- (void)invokeOverlayTappedAction:(id)sender {
    [self overlayTappedBlock]();
}

@end
