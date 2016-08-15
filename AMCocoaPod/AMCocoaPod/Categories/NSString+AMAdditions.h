//
//  NSString+AMAdditions.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 06/10/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AMAdditions)

- (NSString*)stringByInsertingPrefix:(NSString*)prefix;
- (NSString*)trim;
- (NSString*)capitalizeOnlyFirstLetterString;
- (BOOL)isEmptyString;
- (BOOL)isNilOrEmptyString __attribute__((deprecated));
- (NSString*)reversedString;
- (BOOL)isEmptyAfterTrimmingWhiteSpaces;
- (BOOL)isValidEmail;
- (BOOL)isNumber;
- (NSString*)encodeForURL;
+ (NSString*)randomStringWithLength:(NSUInteger)length withCharactersOnString:(NSString*)characters;
+ (NSString*)randomStringWithLength:(NSUInteger)length;
- (BOOL)isValidPhoneNumber;
- (NSString*)sha1;
- (NSString*)md5;

/**
 Generate a unique identifier
 */
+ (NSString *)generateUniqueIdentifier;

/**
 Convert an NSNumber object to an NSString that represents a danish price.
 */
+ (NSString*)formatToDanishKrone:(NSNumber*)price;

/**
 Convert an NSNumber object to an NSString that represents a price based on current locale.
 */
+ (NSString*)formatToCurrency:(NSNumber*)price;

/**
 Use base 64 encoding from string. Typically used for encoding basic authentification header.
 */
+ (NSString *)base64EncodedStringFromString:(NSString*)string;

@end
