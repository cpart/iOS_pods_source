//
//  MKMapView+AMAdditions.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 08/10/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import "MKMapView+AMAdditions.h"

@implementation MKMapView (AMAdditions)

- (CLLocationCoordinate2D)topCenterCoordinate {
    // to get coordinate from CGPoint of your map
    CLLocationCoordinate2D topCenterCoor = [self convertPoint:CGPointMake(self.frame.size.width / 2.0f, 0) toCoordinateFromView:self];
    return topCenterCoor;
}

- (CLLocationDistance)radius {
    CLLocationCoordinate2D centerCoor = [self centerCoordinate];
    // init center location from center coordinate
    CLLocation *centerLocation = [[CLLocation alloc] initWithLatitude:centerCoor.latitude longitude:centerCoor.longitude];
    
    CLLocationCoordinate2D topCenterCoor = [self topCenterCoordinate];
    CLLocation *topCenterLocation = [[CLLocation alloc] initWithLatitude:topCenterCoor.latitude longitude:topCenterCoor.longitude];
    
    CLLocationDistance radius = [centerLocation distanceFromLocation:topCenterLocation];
    
    return radius;
}

- (CLLocationDistance)radiusAccurate {
    // get center coordinate
    CLLocationCoordinate2D centerCoor = [self centerCoordinate];
    CLLocation *centerLocation = [[CLLocation alloc] initWithLatitude:centerCoor.latitude longitude:centerCoor.longitude];
    
    // get top left coordinate
    CLLocationCoordinate2D topLeftCoor = [self convertPoint:CGPointMake(0, 0) toCoordinateFromView:self];
    CLLocation *topLeftLocation = [[CLLocation alloc] initWithLatitude:topLeftCoor.latitude longitude:topLeftCoor.longitude];
    
    // get top right coordinate
    CLLocationCoordinate2D topRightCoor = [self convertPoint:CGPointMake(self.frame.size.width, 0) toCoordinateFromView:self];
    CLLocation *topRightLocation = [[CLLocation alloc] initWithLatitude:topRightCoor.latitude longitude:topRightCoor.longitude];
    
    // the distance from center to top left
    CLLocationDistance hypotenuse = [centerLocation distanceFromLocation:topLeftLocation];
    
    // half of the distance from top left to top right
    CLLocationDistance x = [topLeftLocation distanceFromLocation:topRightLocation] / 2.0f;
    
    // what we want is this
    CLLocationDistance y = sqrt(pow(hypotenuse, 2.0) - pow(x, 2.0));
    NSLog(@"h² = x² + y²");
    NSLog(@"y² = h² - x²");
    NSLog(@"y = sqrt(h² - x²)");
    NSLog(@"%.9f = sqrt(%.9f² - %.9f²)", y, hypotenuse, x);
    
    return y;
}

@end
