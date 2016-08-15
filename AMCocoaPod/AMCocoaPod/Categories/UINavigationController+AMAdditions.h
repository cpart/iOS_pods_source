//
//  UINavigationController+AMAdditions.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 11/09/14.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (AMAdditions)

typedef void (^ overlayTappedBlock)(void);

@property (nonatomic) overlayTappedBlock overlayTappedBlock;

- (void)showOverlayWithColor:(UIColor*)color opacity:(CGFloat)opacity animated:(BOOL)animated userInteractionEnabled:(BOOL)userInteractionEnabled;
- (void)showOverlayWithColor:(UIColor*)color opacity:(CGFloat)opacity animated:(BOOL)animated userInteractionEnabled:(BOOL)userInteractionEnabled blurred:(BOOL)blurred;
- (void)hideOverlay:(BOOL)animated;

- (void)addTapGestureRecognizerToOverlay:(overlayTappedBlock)block;
- (void)passPanGestureRecognizer:(UIPanGestureRecognizer*)panGesture;
- (void)invokeOverlayTappedAction:(id)sender;

@end
