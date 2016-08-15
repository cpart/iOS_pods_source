//
//  UIImageView+AMAddition.m
//  Husqvarna
//
//  Created by Raúl Pérez on 17/02/15.
//  Copyright (c) 2015 Adap Mobile ApS. All rights reserved.
//

#import "UIImageView+AMAdditions.h"
#import "UIView+AMAdditions.h"

static NSInteger activityIndicatorTag = 2000;

@implementation UIImageView (AMAdditions)


- (void)showActivityIndicator {
    [self showActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhite];
}

- (void)showActivityIndicatorWithColor:(UIColor*)color {
    [self showActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhite color:color];
}

- (void)showActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style {
    [self showActivityIndicatorWithStyle:style color:nil];
}

- (void)showActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style color:(UIColor*)color {
    UIActivityIndicatorView* activityIndication = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    
    activityIndication.tag = activityIndicatorTag;
    
    if (color) {
        activityIndication.color = color;
    }
    
    [self addSubview:activityIndication];
    
    [activityIndication addConstraintsToCenterOnSuperview];
    
    [activityIndication startAnimating];
}

- (void)hideActivityIndicator {
    UIActivityIndicatorView* activityIndication = (UIActivityIndicatorView*)[self viewWithTag:activityIndicatorTag];
    
    [activityIndication stopAnimating];
    [activityIndication removeFromSuperview];
}

@end
