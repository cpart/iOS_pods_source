//
//  UIButton+AMAdditions.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 01/10/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import "UIButton+AMAdditions.h"

@implementation UIButton (AMAdditions)

- (void)setBackgroundColor:(UIColor*)color forState:(UIControlState)state {
    UIView *colorView = [[UIView alloc] initWithFrame:self.frame];
    colorView.backgroundColor = color;
    
    UIGraphicsBeginImageContext(colorView.bounds.size);
    [colorView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self setBackgroundImage:colorImage forState:state];
}

@end
