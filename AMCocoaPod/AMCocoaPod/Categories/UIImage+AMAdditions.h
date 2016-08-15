//
//  UIImage+AMAdditions.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 16/09/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AMAdditions)

+ (UIImage*)filledImageFrom:(UIImage*)source withColor:(UIColor *)color;
+ (UIImage*)translucentImageFromImage:(UIImage*)image withAlpha:(CGFloat)alpha;
+ (UIImage*)blendBackgroundImage:(UIImage*)backgroundImage foregroundImage:(UIImage*)foregroundImage;
+ (UIImage*)blendBackgroundImage:(UIImage*)backgroundImage foregroundImage:(UIImage*)foregroundImage point:(CGPoint)point;
+ (UIImage*)imageWithString:(NSString*)string attributes:(NSDictionary*)attributes size:(CGSize)size;
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)size;
+ (UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size;
- (UIImage*)fixOrientation;

@end
