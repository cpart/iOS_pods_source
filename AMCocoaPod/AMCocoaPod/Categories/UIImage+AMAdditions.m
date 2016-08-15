//
//  UIImage+AMAdditions.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 16/09/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import "UIImage+AMAdditions.h"

@implementation UIImage (AMAdditions)

+ (UIImage*)filledImageFrom:(UIImage*)source withColor:(UIColor *)color{
    
    // begin a new image context, to draw our colored image onto with the right scale
    UIGraphicsBeginImageContextWithOptions(source.size, NO, [UIScreen mainScreen].scale);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, source.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, source.size.width, source.size.height);
    CGContextDrawImage(context, rect, source.CGImage);
    
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return the color-burned image
    return coloredImg;
}

+ (UIImage*)translucentImageFromImage:(UIImage*)image withAlpha:(CGFloat)alpha {
    CGRect rect = CGRectZero;
    rect.size = image.size;
    
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:rect blendMode:kCGBlendModeScreen alpha:alpha];
    UIImage *translucentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return translucentImage;
}

+ (UIImage*)blendBackgroundImage:(UIImage*)backgroundImage foregroundImage:(UIImage*)foregroundImage {
    CGSize newSize = CGSizeMake(backgroundImage.size.width, backgroundImage.size.height);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0f);
    
    // Use existing opacity as is
    [backgroundImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Apply supplied opacity
    [foregroundImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height) blendMode:kCGBlendModeNormal alpha:1.0f];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage*)blendBackgroundImage:(UIImage*)backgroundImage foregroundImage:(UIImage*)foregroundImage point:(CGPoint)point {
    UIGraphicsBeginImageContextWithOptions(backgroundImage.size, NO, 0.0f);
    
    // Use existing opacity as is
    [backgroundImage drawInRect:CGRectMake(0,0,backgroundImage.size.width,backgroundImage.size.height)];
    // Apply supplied opacity
    [foregroundImage drawInRect:CGRectMake(point.x, point.y, foregroundImage.size.width, foregroundImage.size.height) blendMode:kCGBlendModeNormal alpha:1.0f];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage*)imageWithString:(NSString*)string attributes:(NSDictionary*)attributes size:(CGSize)size {
    // Create a context to render into.
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    // Work out what size of font will give us a rendering of the string
    // that will fit in an image of the desired size.
    
    // We do this by measuring the string at the given font size and working
    // out the ratio scale to it by to get the desired size of image.
    
    // Measure the string size.
    CGSize stringSize = [string sizeWithAttributes:attributes];
    
    // Work out what it should be scaled by to get the desired size.
    CGFloat xRatio = size.width / stringSize.width;
    CGFloat yRatio = size.height / stringSize.height;
    CGFloat ratio = MIN(xRatio, yRatio);
    
    // Work out the point size that'll give us the desired image size, and
    // create a UIFont that size.
    UIFont *font = [attributes valueForKey:NSFontAttributeName];
    
    CGFloat oldFontSize = font.pointSize;
    CGFloat newFontSize = floor(oldFontSize * ratio);
    //ratio = newFontSize / oldFontSize;
    font = [font fontWithSize:newFontSize];
    
    NSMutableDictionary *newAttributes = [NSMutableDictionary dictionaryWithDictionary:attributes];
    
    [newAttributes setValue:font forKey:NSFontAttributeName];
    
    // What size is the string with this new font?
    stringSize = [string sizeWithAttributes:newAttributes];
    
    // Work out where the origin of the drawn string should be to get it in
    // the centre of the image.
    CGPoint textOrigin = CGPointMake((size.width - stringSize.width) / 2, (size.height - stringSize.height) / 2);
    
    // Draw the string into out image!
    [string drawAtPoint:textOrigin withAttributes:newAttributes];
    
    // We're done!  Grab the image and return it!
    // (Don't forget to end the image context first though!)
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return retImage;
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size {
    UIGraphicsBeginImageContext(size);

    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGRect fillRect = CGRectMake(0,0,size.width,size.height);
    
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextFillRect(currentContext, fillRect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    return image;
}

- (UIImage*)fixOrientation {
    
    //No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
