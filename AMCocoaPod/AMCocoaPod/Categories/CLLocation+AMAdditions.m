//
//  CLLocation+AMAdditions.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 08/10/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import "CLLocation+AMAdditions.h"

@implementation CLLocation (AMAdditions)

- (CLLocationCoordinate2D)randomLocationCoordinate2DWithRadius:(int)radius {
    return [CLLocation randomLocationCoordinate2DWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude radius:radius];
}

+ (CLLocationCoordinate2D)randomLocationCoordinate2DWithLatitude:(double)latitude longitude:(double)longitude radius:(int)radius {
    
    // Convert radius from meters to degrees
    double radiusInDegrees = radius / 111000.0f;
    
    double u = ((double)arc4random() / 0x100000000);
    double v = ((double)arc4random() / 0x100000000);
    double w = radiusInDegrees * sqrt(u);
    double t = 2 * M_PI * v;
    double x = w * cos(t);
    double y = w * sin(t);
    
    // Adjust the x-coordinate for the shrinking of the east-west distances
    double new_x = x / cos(longitude);
    
    double newLongitude = new_x + longitude;
    double newLatitude = y + latitude;
    NSLog(@"Latitude: %lf - Longitude: %lf", newLatitude, newLongitude);
    
    return CLLocationCoordinate2DMake(newLatitude, newLongitude);
}

@end
