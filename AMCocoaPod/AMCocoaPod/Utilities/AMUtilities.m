//
//  AMUtilities.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 06/10/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import "AMUtilities.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <sys/utsname.h>

@implementation AMUtilities

#pragma mark - Actions

+ (void)sendMailToReceiver:(NSString *)receiver {
    
    NSString *mailString = [NSString stringWithFormat:@"mailto:%@", receiver];
    
    NSURL *mailUrl = [NSURL URLWithString:mailString];
    
    if([[UIApplication sharedApplication]canOpenURL:mailUrl]) {
        
        [[UIApplication sharedApplication]openURL:mailUrl];
        
    } else {
        
        //TODO: give error message
        
    }
    
}



+ (void)callPhoneNumber:(NSString *)number {
    
    NSString *phoneNumber = [NSString stringWithFormat:@"tel:%@", number];
    
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""]; //Trim for spaces
    
    NSURL *callUrl = [NSURL URLWithString:phoneNumber];
    
    if([[UIApplication sharedApplication]canOpenURL:callUrl]) {
        
        [[UIApplication sharedApplication]openURL:callUrl];
        
    } else {
        
        //TODO: give error message
        
    }
    
}

+ (void)navigateToCoordinates:(CLLocationCoordinate2D)coordinates {
    MKPlacemark *endLocation = [[MKPlacemark alloc] initWithCoordinate:coordinates addressDictionary:nil];
    MKMapItem *endingItem = [[MKMapItem alloc] initWithPlacemark:endLocation];
    
    NSMutableDictionary *launchOptions = [[NSMutableDictionary alloc] init];

    [launchOptions setObject:MKLaunchOptionsDirectionsModeDriving forKey:MKLaunchOptionsDirectionsModeKey];
    [endingItem openInMapsWithLaunchOptions:launchOptions];
}

+ (void)navigateToAddress:(NSString *)address withZip:(NSString *)zip {
    [self navigateToAddress:address withZip:zip country:@"Denmark"];
}

+ (void)navigateToAddress:(NSString *)address withZip:(NSString *)zip country:(NSString *)country {
    
    NSString *addressString = [NSString stringWithFormat:@"%@ %@ %@", address, zip, country];
    
    NSLog(@"Address: %@", addressString);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:addressString
     
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     
                     // Convert the CLPlacemark to an MKPlacemark
                     
                     // Note: There's no error checking for a failed geocode
                     
                     CLPlacemark *geocodedPlacemark = [placemarks objectAtIndex:0];
                     
                     MKPlacemark *placemark = [[MKPlacemark alloc]
                                               
                                               initWithCoordinate:geocodedPlacemark.location.coordinate
                                               
                                               addressDictionary:geocodedPlacemark.addressDictionary];
                     
                     
                     
                     // Create a map item for the geocoded address to pass to Maps app
                     
                     MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
                     
                     [mapItem setName:geocodedPlacemark.name];
                     
                     
                     
                     // Set the directions mode to "Driving"
                     
                     // Can use MKLaunchOptionsDirectionsModeWalking instead
                     
                     NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
                     
                     
                     
                     // Get the "Current User Location" MKMapItem
                     
                     MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
                     
                     
                     
                     // Pass the current location and destination map items to the Maps app
                     
                     // Set the direction mode in the launchOptions dictionary
                     
                     [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem] launchOptions:launchOptions];
                     
                 }];
    
}

+ (void)openExternalWebSite:(NSString*)website {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:website]];
}

+ (BOOL)openAppWithURLSchema:(NSString*)schema path:(NSString*)path {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:[schema stringByAppendingString:path]];
    
    if ([application canOpenURL:url]) {
        [application openURL:url];
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Numbers

+ (NSUInteger)randomIntegerBetweenMin:(NSUInteger)min max:(NSUInteger)max {
    return arc4random() % (max - min) + min;
}

+ (NSString*)deviceModelName {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *machineName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    NSDictionary *commonNamesDictionary =
    @{
      @"i386": kDevice_Simulator,
      @"x86_64": kDevice_Simulator,
      
      @"iPhone1,1": kDevice_iPhone,
      @"iPhone1,2": kDevice_iPhone_3G,
      @"iPhone2,1": kDevice_iPhone_3GS,
      @"iPhone3,1": kDevice_iPhone_4,
      @"iPhone3,2": kDevice_iPhone_4_Rev_A,
      @"iPhone3,3": kDevice_iPhone_4_CDMA,
      @"iPhone4,1": kDevice_iPhone_4S,
      @"iPhone5,1": kDevice_iPhone_5_GSM,
      @"iPhone5,2": kDevice_iPhone_5_GSM_CDMA,
      @"iPhone5,3": kDevice_iPhone_5c_GSM,
      @"iPhone5,4": kDevice_iPhone_5c_GSM_CDMA,
      @"iPhone6,1": kDevice_iPhone_5s_GSM,
      @"iPhone6,2": kDevice_iPhone_5s_GSM_CDMA,
      
      @"iPhone7,1": kDevice_iPhone_6Plus_GSM_CDMA,
      @"iPhone7,2": kDevice_iPhone_6_GSM_CDMA,

      @"iPhone8,1": kDevice_iPhone_6s_GSM_CDMA,
      @"iPhone8,2": kDevice_iPhone_6sPlus_GSM_CDMA,
      
      @"iPad1,1": kDevice_iPad,
      @"iPad2,1": kDevice_iPad_2_WiFi,
      @"iPad2,2": kDevice_iPad_2_GSM,
      @"iPad2,3": kDevice_iPad_2_CDMA,
      @"iPad2,4": kDevice_iPad_2_WiFi_Rev_A,
      
      @"iPad2,5": kDevice_iPad_Mini_1G_WiFi,
      @"iPad2,6": kDevice_iPad_Mini_1G_GSM,
      @"iPad2,7": kDevice_iPad_Mini_1G_GSM_CDMA,
      
      @"iPad3,1": kDevice_iPad_3_WiFi,
      @"iPad3,2": kDevice_iPad_3_GSM_CDMA,
      @"iPad3,3": kDevice_iPad_3_GSM,
      @"iPad3,4": kDevice_iPad_4_WiFi,
      @"iPad3,5": kDevice_iPad_4_GSM,
      @"iPad3,6": kDevice_iPad_4_GSM_CDMA,
      
      @"iPad4,1": kDevice_iPad_Air_WiFi,
      @"iPad4,2": kDevice_iPad_Air_GSM,
      @"iPad4,3": kDevice_iPad_Air_GSM_CDMA,
      
      @"iPad4,4": kDevice_iPad_Mini_2G_WiFi,
      @"iPad4,5": kDevice_iPad_Mini_2G_GSM,
      @"iPad4,6": kDevice_iPad_Mini_2G_GSM_CDMA,
      
      @"iPod1,1": kDevice_iPod_1st_Gen,
      @"iPod2,1": kDevice_iPod_2nd_Gen,
      @"iPod3,1": kDevice_iPod_3rd_Gen,
      @"iPod4,1": kDevice_iPod_4th_Gen,
      @"iPod5,1": kDevice_iPod_5th_Gen
      };
    
    NSString *deviceName = commonNamesDictionary[machineName];
    
    if (deviceName == nil) {
        deviceName = machineName;
    }
    
    return deviceName;
}

+ (NSString*)deviceFamily {
    NSString *deviceModel = [AMUtilities deviceModelName];
    
    if ([[deviceModel lowercaseString] hasPrefix:@"iphone"]) {
        return @"iPhone";
    } else if ([[deviceModel lowercaseString] hasPrefix:@"ipad"]) {
        return @"iPad";
    } else if ([[deviceModel lowercaseString] hasPrefix:@"ipod"]) {
        return @"iPod";
    } else {
        return @"Simulator";
    }
}

+ (BOOL)isRunningSimulator {
    NSString *deviceName = [AMUtilities deviceModelName];
    
    if ([deviceName isEqualToString:kDevice_Simulator]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isIPhone4 {
    NSString *deviceName = [AMUtilities deviceModelName];
    
    if (
        [deviceName isEqualToString:kDevice_iPhone_4]
        || [deviceName isEqualToString:kDevice_iPhone_4_CDMA]
        || [deviceName isEqualToString:kDevice_iPhone_4_Rev_A]
        || [deviceName isEqualToString:kDevice_iPhone_4S]
        ) {
        return YES;
    } else if ([AMUtilities isRunningSimulator]) {
        if ([ [ UIScreen mainScreen ] bounds ].size.height == 480.0f) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isIPhone5 {
    NSString *deviceName = [AMUtilities deviceModelName];
    
    if (
        [deviceName isEqualToString:kDevice_iPhone_5_GSM]
        || [deviceName isEqualToString:kDevice_iPhone_5_GSM_CDMA]
        || [deviceName isEqualToString:kDevice_iPhone_5c_GSM]
        || [deviceName isEqualToString:kDevice_iPhone_5c_GSM_CDMA]
        || [deviceName isEqualToString:kDevice_iPhone_5s_GSM]
        || [deviceName isEqualToString:kDevice_iPhone_5s_GSM_CDMA]
        ) {
        return YES;
    } else if ([AMUtilities isRunningSimulator]) {
        if ([ [ UIScreen mainScreen ] bounds ].size.height == 568.0f) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isIPhone6 {
    NSString *deviceName = [AMUtilities deviceModelName];
    
    if (
        [deviceName isEqualToString:kDevice_iPhone_6_GSM_CDMA]
        || [deviceName isEqualToString:kDevice_iPhone_6s_GSM_CDMA]
        ) {
        return YES;
    } else if ([AMUtilities isRunningSimulator]) {
        if ([ [ UIScreen mainScreen ] bounds ].size.height == 667.0f) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isIPhone6Plus {
    NSString *deviceName = [AMUtilities deviceModelName];
    
    if (
        [deviceName isEqualToString:kDevice_iPhone_6Plus_GSM_CDMA]
        || [deviceName isEqualToString:kDevice_iPhone_6sPlus_GSM_CDMA]
        ) {
        return YES;
    } else if ([AMUtilities isRunningSimulator]) {
        if ([ [ UIScreen mainScreen ] bounds ].size.height == 736.0f) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isIPod3th {
    NSString *deviceName = [AMUtilities deviceModelName];
    
    if (
        [deviceName isEqualToString:kDevice_iPod_3rd_Gen]
        ) {
        return YES;
    } else if ([AMUtilities isRunningSimulator]) {
        if ([ [ UIScreen mainScreen ] bounds ].size.height == 480.0f  && [[UIScreen mainScreen] scale] == 1.0f) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isIPod4th {
    NSString *deviceName = [AMUtilities deviceModelName];
    
    if (
        [deviceName isEqualToString:kDevice_iPod_4th_Gen]
        ) {
        return YES;
    } else if ([AMUtilities isRunningSimulator]) {
        if ([ [ UIScreen mainScreen ] bounds ].size.height == 480.0f && [[UIScreen mainScreen] scale] == 2.0f) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isIPod5th {
    NSString *deviceName = [AMUtilities deviceModelName];
    
    if (
        [deviceName isEqualToString:kDevice_iPod_5th_Gen]
        ) {
        return YES;
    } else if ([AMUtilities isRunningSimulator]) {
        if ([ [ UIScreen mainScreen ] bounds ].size.height == 568.0f) {
            return YES;
        }
    }
    
    return NO;
}


#pragma mark - Fonts

+ (void)showAllFonts {
    NSMutableArray *fontNames = [[NSMutableArray alloc] init];
    
    NSArray *fontFamilyNames = [UIFont familyNames];
    
    for (NSString *familyName in fontFamilyNames) {
        NSLog(@"Font Family Name = %@", familyName);
        
        NSArray *names = [UIFont fontNamesForFamilyName:familyName];
        
        NSLog(@"Font Names = %@", fontNames);
        
        [fontNames addObjectsFromArray:names];
    }
}

#pragma mark - App Info

+ (NSString*)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString*)appBuild {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString*)appName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

+ (NSString*)appBundle {
    return [[NSBundle mainBundle] bundleIdentifier];;
}


@end
