//
//  UINavigationController+BlackStatusBar.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 12/09/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import "UINavigationController+BlackStatusBar.h"

@implementation UINavigationController (BlackStatusBar)

#pragma mark - UIViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
