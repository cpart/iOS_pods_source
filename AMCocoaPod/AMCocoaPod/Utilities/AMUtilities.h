//
//  AMUtilities.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 06/10/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define kDevice_Simulator @"Simulator"
#define kDevice_iPhone @"iPhone"
#define kDevice_iPhone_3G @"iPhone 3G"
#define kDevice_iPhone_3GS @"iPhone 3GS"
#define kDevice_iPhone_4 @"iPhone 4"
#define kDevice_iPhone_4_Rev_A @"iPhone 4(Rev A)"
#define kDevice_iPhone_4_CDMA @"iPhone 4(CDMA)"
#define kDevice_iPhone_4S @"iPhone 4S"
#define kDevice_iPhone_5_GSM @"iPhone 5(GSM)"
#define kDevice_iPhone_5_GSM_CDMA @"iPhone 5(GSM+CDMA)"
#define kDevice_iPhone_5c_GSM @"iPhone 5c(GSM)"
#define kDevice_iPhone_5c_GSM_CDMA @"iPhone 5c(GSM+CDMA)"
#define kDevice_iPhone_5s_GSM @"iPhone 5s(GSM)"
#define kDevice_iPhone_5s_GSM_CDMA @"iPhone 5s(GSM+CDMA)"
#define kDevice_iPhone_6Plus_GSM_CDMA @"iPhone 6+ (GSM+CDMA)"
#define kDevice_iPhone_6_GSM_CDMA @"iPhone 6 (GSM+CDMA)"
#define kDevice_iPhone_6sPlus_GSM_CDMA @"iPhone 6s+ (GSM+CDMA)"
#define kDevice_iPhone_6s_GSM_CDMA @"iPhone 6s (GSM+CDMA)"
#define kDevice_iPad @"iPad"
#define kDevice_iPad_2_WiFi @"iPad 2(WiFi)"
#define kDevice_iPad_2_GSM @"iPad 2(GSM)"
#define kDevice_iPad_2_CDMA @"iPad 2(CDMA)"
#define kDevice_iPad_2_WiFi_Rev_A @"iPad 2(WiFi Rev A)"
#define kDevice_iPad_Mini_1G_WiFi @"iPad Mini 1G (WiFi)"
#define kDevice_iPad_Mini_1G_GSM @"iPad Mini 1G (GSM)"
#define kDevice_iPad_Mini_1G_GSM_CDMA @"iPad Mini 1G (GSM+CDMA)"
#define kDevice_iPad_3_WiFi @"iPad 3(WiFi)"
#define kDevice_iPad_3_GSM_CDMA @"iPad 3(GSM+CDMA)"
#define kDevice_iPad_3_GSM @"iPad 3(GSM)"
#define kDevice_iPad_4_WiFi @"iPad 4(WiFi)"
#define kDevice_iPad_4_GSM @"iPad 4(GSM)"
#define kDevice_iPad_4_GSM_CDMA @"iPad 4(GSM+CDMA)"
#define kDevice_iPad_Air_WiFi @"iPad Air(WiFi)"
#define kDevice_iPad_Air_GSM @"iPad Air(GSM)"
#define kDevice_iPad_Air_GSM_CDMA @"iPad Air(GSM+CDMA)"
#define kDevice_iPad_Mini_2G_WiFi @"iPad Mini 2G (WiFi)"
#define kDevice_iPad_Mini_2G_GSM @"iPad Mini 2G (GSM)"
#define kDevice_iPad_Mini_2G_GSM_CDMA @"iPad Mini 2G (GSM+CDMA)"
#define kDevice_iPod_1st_Gen @"iPod 1st Gen"
#define kDevice_iPod_2nd_Gen @"iPod 2nd Gen"
#define kDevice_iPod_3rd_Gen @"iPod 3rd Gen"
#define kDevice_iPod_4th_Gen @"iPod 4th Gen"
#define kDevice_iPod_5th_Gen @"iPod 5th Gen"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface AMUtilities : NSObject

//Actions

+ (void)sendMailToReceiver:(NSString *)receiver;
+ (void)callPhoneNumber:(NSString *)number;
+ (void)navigateToCoordinates:(CLLocationCoordinate2D)coordinates;
+ (void)navigateToAddress:(NSString *)address withZip:(NSString *)zip;
+ (void)navigateToAddress:(NSString *)address withZip:(NSString *)zip country:(NSString*)country;
+ (void)openExternalWebSite:(NSString*)website;
+ (BOOL)openAppWithURLSchema:(NSString*)schema path:(NSString*)path;

//Numbers

+ (NSUInteger)randomIntegerBetweenMin:(NSUInteger)min max:(NSUInteger)max;

//Device

+ (NSString*)deviceModelName;
+ (NSString*)deviceFamily;
+ (BOOL)isRunningSimulator;
+ (BOOL)isIPhone4;
+ (BOOL)isIPhone5;
+ (BOOL)isIPhone6;
+ (BOOL)isIPhone6Plus;
+ (BOOL)isIPod3th;
+ (BOOL)isIPod4th;
+ (BOOL)isIPod5th;


//Fonts
+ (void)showAllFonts;

//App Info
+ (NSString*)appVersion;
+ (NSString*)appBuild;
+ (NSString*)appName;
+ (NSString*)appBundle;

@end
