//
//  UIViewController+AMAdditions.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 11/09/14.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AMAdditions)

- (void)showOverlayWithColor:(UIColor*)color opacity:(CGFloat)opacity animated:(BOOL)animated userInteractionEnabled:(BOOL)userInteractionEnabled;
- (void)hideOverlay:(BOOL)animated;

/**
 Present a view controller modally using a storyboard name and a view controller storyboard id.
 The method is similar to presentViewController:animated:completion:.
 Animation prameters should be set from attributes inspector.
 */
- (void)presentViewControllerWithId:(NSString*)identifier
                     fromStoryboard:(NSString*)storyboard
                           animated:(BOOL)animated
                         completion:(void(^)(id))completion;

@end
