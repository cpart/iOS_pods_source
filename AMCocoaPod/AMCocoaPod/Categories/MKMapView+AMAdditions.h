//
//  MKMapView+AMAdditions.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 08/10/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (AMAdditions)

- (CLLocationCoordinate2D)topCenterCoordinate;
- (CLLocationDistance)radius;
- (CLLocationDistance)radiusAccurate;

@end
