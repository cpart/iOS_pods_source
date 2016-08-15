//
//  NSString+AMAdditions.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 06/10/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import "NSString+AMAdditions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (AMAdditions)

#pragma mark - Checks

- (BOOL)isEmptyAfterTrimmingWhiteSpaces {
    if ([[self trim] length] == 0) {
        return YES;
    }
    return NO;
}
/**
 Check if string is a valid email
 */
- (BOOL)isValidEmail {
    BOOL stricterFilter = false;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/**
 Check if string satisfies a minimum length. 
 (equals or superior to parameter)
 */
- (BOOL)isValidLength:(int)minLength{
    if (self.length < minLength || [self isEmptyAfterTrimmingWhiteSpaces]) {
        return false;
    }
    return true;
}

- (BOOL)isNumber {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    if ([numberFormatter numberFromString:self]) {
        return YES;
    }
    return NO;
}

- (BOOL)isValidPhoneNumber {
    NSString *phoneRegex = @"^((\\+)|(00)|())[0-9]{8,14}$";
    
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL matches = [test evaluateWithObject:self];
    return matches;
}

- (BOOL)isEmptyString {
    if ([self isEqualToString:[NSString string]]) {
        return YES;
    }
    return NO;
}

- (BOOL)isNilOrEmptyString __attribute__((deprecated("Deprecated don't use it"))) {
    if (self == nil || [self isEmptyString]) {
        return YES;
    }
    return NO;
}

#pragma mark - Formatter

/**
 Convert an NSNumber object to an NSString that represents a danish price.
 */
+ (NSString*)formatToDanishKrone:(NSNumber*)price{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"da"]];
    [formatter setCurrencySymbol:@""];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setAlwaysShowsDecimalSeparator:NO];
    return [formatter stringFromNumber:price];
}

/**
 Convert an NSNumber object to an NSString that represents a price based on current locale.
 */
+ (NSString*)formatToCurrency:(NSNumber*)price{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setCurrencySymbol:@""];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setAlwaysShowsDecimalSeparator:NO];
    return [formatter stringFromNumber:price];
}

#pragma mark - Generators

/**
 Generate a unique identifier
 */
+ (NSString *)generateUniqueIdentifier{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge_transfer NSString *)uuidStringRef;
}

+ (NSString*)randomStringWithLength:(NSUInteger)length {
    return [NSString randomStringWithLength:length withCharactersOnString:nil];
}

+ (NSString*)randomStringWithLength:(NSUInteger)length withCharactersOnString:(NSString*)characters {
    NSString *defaultCharacters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    if (characters) {
        defaultCharacters = characters;
    }
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (NSUInteger i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [defaultCharacters characterAtIndex:arc4random_uniform((u_int32_t)[defaultCharacters length])]];
    }
    
    return randomString;
}

#pragma mark - Encoding and Decoding

/**
 This is useful when using a font icon. encode a icon code before setting it to a UILabel.
 */
+ (NSString*)encodedStringWithString:(NSString*)string {
    return [NSString stringWithCString:[string cStringUsingEncoding:NSUTF8StringEncoding]
                              encoding:NSNonLossyASCIIStringEncoding];
}

- (NSString*) stringByInsertingPrefix:(NSString*)prefix {
    return [NSString stringWithFormat:@"%@%@", prefix, self];
}

- (NSString*)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString*)capitalizeOnlyFirstLetterString {
    return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[self substringToIndex:1] capitalizedString]];
}

- (NSString*)reversedString {
    NSUInteger len = [self length];
    unichar *buffer = malloc(len * sizeof(unichar));
    if (buffer == nil) return nil; // error!
    [self getCharacters:buffer];
    
    // reverse string; only need to loop through first half
    for (NSUInteger stPos=0, endPos=len-1; stPos < len/2; stPos++, endPos--) {
        unichar temp = buffer[stPos];
        buffer[stPos] = buffer[endPos];
        buffer[endPos] = temp;
    }
    
    return [[NSString alloc] initWithCharactersNoCopy:buffer length:len freeWhenDone:YES];
}

- (NSString*)encodeForURL {
    NSMutableString *output = [NSMutableString string];
    
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    
    int sourceLen = (int)strlen((const char *)source);
    
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

- (NSString*)sha1 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *hashedValueSHA1 = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [hashedValueSHA1 appendFormat:@"%02x", digest[i]];
    }
    
    return hashedValueSHA1;
}

- (NSString*)md5 {
    const char *cStr = [self UTF8String];
    
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return  output;
}

+ (NSString *)base64EncodedStringFromString:(NSString*)string
{
    NSData *data = [NSData dataWithBytes:[string UTF8String] length:[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger length = [data length];
    NSMutableData *mutableData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    
    uint8_t *input = (uint8_t *)[data bytes];
    uint8_t *output = (uint8_t *)[mutableData mutableBytes];
    
    for (NSUInteger i = 0; i < length; i += 3) {
        NSUInteger value = 0;
        for (NSUInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        static uint8_t const kAFBase64EncodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        
        NSUInteger idx = (i / 3) * 4;
        output[idx + 0] = kAFBase64EncodingTable[(value >> 18) & 0x3F];
        output[idx + 1] = kAFBase64EncodingTable[(value >> 12) & 0x3F];
        output[idx + 2] = (i + 1) < length ? kAFBase64EncodingTable[(value >> 6)  & 0x3F] : '=';
        output[idx + 3] = (i + 2) < length ? kAFBase64EncodingTable[(value >> 0)  & 0x3F] : '=';
    }
    return [[NSString alloc] initWithData:mutableData encoding:NSASCIIStringEncoding];
}

@end
