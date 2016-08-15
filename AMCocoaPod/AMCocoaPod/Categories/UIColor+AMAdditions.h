//
//  UIColor+AMAdditions.h
//  MyDay
//
//  Created by Anton Schmidt Gregersen on 15/08/14.
//  Copyright (c) 2014 Adapt Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AMAdditions)

+ (UIColor*)customShadowColor;

+ (UIColor*)colorWithHexString:(NSString*)hexString;

+ (UIColor*)randomColor;

@end
