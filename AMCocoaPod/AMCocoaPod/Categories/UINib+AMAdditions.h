//
//  UINib+AMAdditions.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 28/01/15.
//  Copyright (c) 2015 Adap Mobile ApS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (AMAdditions)

+ (UIView*)loadNibNamed:(NSString *)nibName owner:(id)owner;
+ (UIView*)loadNibNamed:(NSString *)nibName owner:(id)owner atPosition:(NSInteger)position;

@end
