//
//  UINavigationController+WhiteStatusBar.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 12/09/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import "UINavigationController+WhiteStatusBar.h"

@implementation UINavigationController (WhiteStatusBar)

#pragma mark - UIViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
