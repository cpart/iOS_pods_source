//
//  UIImageView+AMAddition.h
//  Husqvarna
//
//  Created by Raúl Pérez on 17/02/15.
//  Copyright (c) 2015 Adap Mobile ApS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (AMAdditions)

/***
 * Activity Indicator Additions
 */

- (void)showActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style;
- (void)showActivityIndicatorWithColor:(UIColor*)color;
- (void)showActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style color:(UIColor*)color;
- (void)showActivityIndicator;
- (void)hideActivityIndicator;

@end
