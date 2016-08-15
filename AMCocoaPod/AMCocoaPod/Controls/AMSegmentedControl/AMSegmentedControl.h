//
//  CustomSegmentedControl.h
//  MyDay
//
//  Created by Raúl Pérez on 18/08/14.
//  Copyright (c) 2014 Adapt Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMSegmentedControl : UISegmentedControl

@property (nonatomic) UIFont *titleFont;
@property (nonatomic) UIColor *titleColor;
@property (nonatomic) NSShadow *titleShadow;
@property (nonatomic) UIImage *backgroundImageStateNormal;
@property (nonatomic) UIImage *backgroundImageStateSelected;
@property (nonatomic) UIImage *separatorImage;

- (void)refresh;

@end
