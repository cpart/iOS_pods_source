//
//  UINib+AMAdditions.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 28/01/15.
//  Copyright (c) 2015 Adap Mobile ApS. All rights reserved.
//

#import "UINib+AMAdditions.h"

@implementation UINib (AMAdditions)

+ (UIView*)loadNibNamed:(NSString *)nibName owner:(id)owner {
    return [UINib loadNibNamed:nibName owner:owner atPosition:0];
}

+ (UIView*)loadNibNamed:(NSString *)nibName owner:(id)owner atPosition:(NSInteger)position {
    UINib *nib = [UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]];
    NSArray *views = [nib instantiateWithOwner:owner options:0];
    return [views objectAtIndex:position];
}

@end
