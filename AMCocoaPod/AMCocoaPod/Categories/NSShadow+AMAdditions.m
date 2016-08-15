//
//  NSShadow+AMAdditions.m
//  MyDay
//
//  Created by Raúl Pérez on 19/08/14.
//  Copyright (c) 2014 Adapt Mobile. All rights reserved.
//

#import "NSShadow+AMAdditions.h"
#import "UIColor+AMAdditions.h"

@implementation NSShadow (AMAdditions)

+ (NSShadow*)customShadow {
    NSShadow *customShadow = [[NSShadow alloc] init];
    
    customShadow.shadowColor = [UIColor customShadowColor];
    customShadow.shadowBlurRadius = 0.0;
    customShadow.shadowOffset = CGSizeMake(1.0, 1.0);
    
    return customShadow;
}

+ (NSShadow*)clearShadow {
    NSShadow *customShadow = [[NSShadow alloc] init];
    
    customShadow.shadowColor = [UIColor clearColor];
    customShadow.shadowBlurRadius = 0.0;
    customShadow.shadowOffset = CGSizeMake(0.0, 0.0);
    
    return customShadow;
}

@end
