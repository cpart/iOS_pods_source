//
//  CLLocation+AMAdditions.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 08/10/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (AMAdditions)

- (CLLocationCoordinate2D)randomLocationCoordinate2DWithRadius:(int)radius;
+ (CLLocationCoordinate2D)randomLocationCoordinate2DWithLatitude:(double)latitude longitude:(double)longitude radius:(int)radius;

@end
