//
//  AMTestManager.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 10/09/14.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import "AMTestManager.h"
#import "NSArray+AMAdditions.h"

#define kShortStringsArrayName @"shortStrings"
#define kLongStringsArrayName @"largeStrings"
#define kIdentifierStringName @"identifier"
#define kCoordinateStringName @"coordinate"
#define kImagesURLStringName @"imagesURL"
#define kWebURLStringName @"webURL"
#define kMobileStringName @"mobile"
#define kPhoneStringName @"phone"
#define kAddressStringName @"address"
#define kPostCodeStringName @"postCode"
#define kCityStringName @"city"
#define kEMailStringName @"eMail"
#define kDiscountStringName @"discount"

static NSString *shortStrings[] = {@"Dapibus integer cursus convallis bibendum",
                                 @"Felis volutpat litora viverra tincidunt nam, dictum quis gravida ultrices vehicula, suscipit faucibus pellentesque cursus",
                                 @"Laoreet lobortis ut conubia magna ad aliquam condimentum",
                                 @"Augue ut velit nec orci sodales massa dapibus ornare",
                                 @"Posuere ante ligula dapibus tortor erat nisl et semper conubia sapien sollicitudin",
                                 @"Fames convallis sit lacus ad pharetra at",
                                 @"Mattis et morbi ipsum magna enim ligula pulvinar sodales, vel taciti mauris fermentum habitasse erat"};

static NSString *largeStrings[] = {@"Crud suggestive much and hypnotic alas found gosh jerkily petulantly infectiously bravely hello and amid adroit through sad a because thus that spread customary before flinched prim away shaky the agitated mastodon.",
                                 @"Where oh this inept and when that joking tiger so more as thus extravagantly giggled the that and filled arousingly inconspicuous inside one regarding precariously gosh frugally and titillating on more dog or other walking more that a yikes chose over.",
                                 @"More a scallop before and hello oh much jellyfish the yet plankton much besides more one however without heinous this before thus some with less while octopus and informal jeepers labrador after less the goodness much.",
                                 @"A hound gosh unselfishly gnu vulture below hence nonchalantly squid satisfactory and tapir smugly on gamely thus cardinally much therefore across firefly zebra tonal on other that lustily hello so after crud the assentingly.",
                                 @"Shakily firefly far yikes deer wasp this redoubtable while dissolutely spacious jealously lazily more shivered dubiously goodness daintily distinctly opposite where alas on far effectively far jeez wow aptly weasel this far burned regardless grimaced until the."};

static NSString *websURLStrings[] = {@"itunesconnect.apple.com",
                                @"www.google.com",
                                @"www.apple.com",
                                @"www.adaptmobile.dk",
                                @"www.itunes.com"};

static NSString *imagesURLStrings[] = {@"http://itunesconnect.apple.com/1.png",
                                @"http://www.google.com/2.png",
                                @"http://www.apple.com/3.png",
                                @"http://www.adaptmobile.dk/4.png",
                                @"http://www.itunes.com/5.png"};

static NSString *mobileStrings[] = {@"55511122",
                                @"555333444",
                                @"555555666",
                                @"555777888",
                                @"555999000"};

static NSString *phoneStrings[] = {@"22211122",
                                @"222333444",
                                @"333555666",
                                @"444777888",
                                @"555999000"};

static NSString *addressStrings[] = {@"Address, 1",
                                @"Address, 2",
                                @"Address, 3",
                                @"Address, 4",
                                @"Address, 5"};

static NSString *postCodesStrings[] = {@"20000",
                                @"30000",
                                @"40000",
                                @"50000",
                                @"60000"};

static NSString *citiesStrings[] = {@"Granada",
                                @"Rome",
                                @"Aarus",
                                @"Copenhagen"};

static NSString *eMailsStrings[] = {@"aaaaa@adaptmobile.dk",
                                @"bbbbb@adaptmobile.dk",
                                @"ccccc@adaptmobile.dk",
                                @"ddddd@adaptmobile.dk"};

static NSString *discountsStrings[] = {@"25",
                                @"30",
                                @"50",
                                @"75"};


@interface AMTestManager ()

@property (nonatomic) NSDictionary *stringsMappings;
@property (nonatomic) NSUInteger identifierCounter;
@property (nonatomic) AMTestManager *sharedManager;

@end

@implementation AMTestManager

- (id)init {
    self = [super init];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (void)initialize {
    self.identifierCounter = 0;
    self.stringsMappings = [[NSDictionary alloc] initWithObjectsAndKeys:
                            kShortStringsArrayName, @"title",
                            kLongStringsArrayName, @"comment",
                            kIdentifierStringName, @"identifier",
                            kCoordinateStringName, @"latitude",
                            kCoordinateStringName, @"longitude",
                            kImagesURLStringName, @"imageURL",
                            kWebURLStringName, @"linkURL",
                            kImagesURLStringName, @"logoURL",
                            kImagesURLStringName, @"backgroundURL",
                            kPhoneStringName, @"mobile",
                            kPhoneStringName, @"phone",
                            kAddressStringName, @"address1",
                            kAddressStringName, @"address2",
                            kPostCodeStringName, @"postCode",
                            kCityStringName, @"city",
                            kWebURLStringName, @"website",
                            kEMailStringName, @"eMail",
                            kShortStringsArrayName, @"titleShort",
                            kDiscountStringName, @"discount",
                            nil];
}

+ (AMTestManager *)sharedManager {
    static AMTestManager *sharedTransitionDelegate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTransitionDelegate = [[AMTestManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedTransitionDelegate;
}

+ (id)populatedInstanceWithClass:(Class)klass {
    NSDictionary *properties = [AMTestManager propertyTypeDictionaryOfClass:klass];
    id instance = [[[klass class] alloc] init];
    
    for (id propertyName in properties.allKeys) {
        if ([[properties valueForKey:propertyName] isEqualToString:NSStringFromClass([NSNumber class])]) {
            [instance setValue:[AMTestManager numberForPropertyName:propertyName] forKey:propertyName];
        } else if ([[properties valueForKey:propertyName] isEqualToString:NSStringFromClass([NSString class])]) {
            [instance setValue:[AMTestManager randomStringForPropertyName:propertyName] forKey:propertyName];
        } else if ([[properties valueForKey:propertyName] isEqualToString:NSStringFromClass([NSDate class])]) {
            [instance setValue:[AMTestManager randomDate] forKey:propertyName];
        } else if ([[properties valueForKey:propertyName] isEqualToString:@"BOOL"]) {
            [instance setValue:[NSNumber numberWithBool:[AMTestManager randomBoolean]] forKey:propertyName];
        }
    }
    
    return instance;
}

+ (NSDate*)randomDate {
    u_int32_t randomNumber = arc4random_uniform(3600);

    return [[NSDate date] dateByAddingTimeInterval:randomNumber];
}

+ (NSNumber*)nextIdentifer {
    [AMTestManager sharedManager].identifierCounter++;
    return [NSNumber numberWithUnsignedInteger:[AMTestManager sharedManager].identifierCounter];
}



+ (NSNumber*)numberForPropertyName:(NSString*)propertyName {
    NSString *stringType = [[AMTestManager sharedManager].stringsMappings objectForKey:propertyName];

    if ([stringType isEqualToString:kIdentifierStringName]) {
        return [AMTestManager nextIdentifer];
    } else if ([stringType isEqualToString:kCoordinateStringName]) {
        return [AMTestManager randomCoordinate];
    } else {
        
        return [AMTestManager randomNumber];
    }
}

+ (NSNumber*)randomCoordinate {
    double latitude = arc4random()%20 + 50;
    return [NSNumber  numberWithDouble:latitude];
}

+ (NSString*)randomStringForPropertyName:(NSString*)propertyName {
    NSString *string = nil;

    NSString *stringType = [[AMTestManager sharedManager].stringsMappings objectForKey:propertyName];

    if ([stringType isEqualToString:kShortStringsArrayName]) {
        string = [AMTestManager randomShortString];
    } else if ([stringType isEqualToString:kLongStringsArrayName]) {
        string = [AMTestManager randomLongString];
    } else if ([stringType isEqualToString:kImagesURLStringName]) {
        string = [AMTestManager randomImagesURLString];
    } else if ([stringType isEqualToString:kWebURLStringName]) {
        string = [AMTestManager randomWebsURLString];
    } else if ([stringType isEqualToString:kPhoneStringName]) {
        string = [AMTestManager randomPhoneString];
    } else if ([stringType isEqualToString:kAddressStringName]) {
        string = [AMTestManager randomAddressString];
    } else if ([stringType isEqualToString:kPostCodeStringName]) {
        string = [AMTestManager randomPostCodeString];
    } else if ([stringType isEqualToString:kCityStringName]) {
        string = [AMTestManager randomCityString];
    } else if ([stringType isEqualToString:kEMailStringName]) {
        string = [AMTestManager randomEMailString];
    } else if ([stringType isEqualToString:kDiscountStringName]) {
        string = [AMTestManager randomDiscountString];
    } else {
        string = @"#### Need to be assign to a mapped type... ####";
    }
    
    return string;
}

+ (NSString*)randomEMailString {
    int count = sizeof(eMailsStrings)/sizeof(eMailsStrings[0]);
    NSArray *array = [NSArray arrayWithObjects:eMailsStrings count:(NSUInteger)count];
    return [array randomObject];
}

+ (NSString*)randomPhoneString {
    int count = sizeof(phoneStrings)/sizeof(phoneStrings[0]);
    NSArray *array = [NSArray arrayWithObjects:phoneStrings count:(NSUInteger)count];
    return [array randomObject];
}

+ (NSString*)randomAddressString {
    int count = sizeof(addressStrings)/sizeof(addressStrings[0]);
    NSArray *array = [NSArray arrayWithObjects:addressStrings count:(NSUInteger)count];
    return [array randomObject];
}

+ (NSString*)randomPostCodeString {
    int count = sizeof(postCodesStrings)/sizeof(postCodesStrings[0]);
    NSArray *array = [NSArray arrayWithObjects:postCodesStrings count:(NSUInteger)count];
    return [array randomObject];
}

+ (NSString*)randomCityString {
    int count = sizeof(citiesStrings)/sizeof(citiesStrings[0]);
    NSArray *array = [NSArray arrayWithObjects:citiesStrings count:(NSUInteger)count];
    return [array randomObject];
}

+ (NSString*)randomDiscountString {
    int count = sizeof(discountsStrings)/sizeof(discountsStrings[0]);
    NSArray *array = [NSArray arrayWithObjects:discountsStrings count:(NSUInteger)count];
    return [array randomObject];
}

+ (NSString*)randomImagesURLString {
    int count = sizeof(imagesURLStrings)/sizeof(imagesURLStrings[0]);
    NSArray *array = [NSArray arrayWithObjects:imagesURLStrings count:(NSUInteger)count];
    return [array randomObject];
}

+ (NSString*)randomWebsURLString {
    int count = sizeof(websURLStrings)/sizeof(websURLStrings[0]);
    NSArray *array = [NSArray arrayWithObjects:websURLStrings count:(NSUInteger)count];
    return [array randomObject];
}

+ (NSString*)randomShortString {
    int count = sizeof(shortStrings)/sizeof(shortStrings[0]);
    NSArray *array = [NSArray arrayWithObjects:shortStrings count:(NSUInteger)count];
    return [array randomObject];
}

+ (NSString*)randomLongString {
    int count = sizeof(largeStrings)/sizeof(largeStrings[0]);
    NSArray *array = [NSArray arrayWithObjects:largeStrings count:(NSUInteger)count];
    return [array randomObject];
}

+ (BOOL)randomBoolean {
    u_int32_t randomNumber = (arc4random() % ((unsigned)RAND_MAX + 1));
    
    if(randomNumber % 3 == 0)
        return YES;
    
    return NO;
}

+ (NSNumber*)randomNumber{
    u_int32_t randomNumber = (arc4random() % ((unsigned)RAND_MAX + 1));
    return [NSNumber numberWithUnsignedInteger:(NSUInteger)randomNumber];
}

+ (NSString*)propertyTypeStringOfProperty:(objc_property_t)property {
    const char *attr = property_getAttributes(property);
    NSString *const attributes = [NSString stringWithCString:attr encoding:NSUTF8StringEncoding];
    
    NSArray *components = [attributes componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
    
    NSString *firstComponent = [components firstObject];
    
    if ([firstComponent isEqualToString:@"TB"]) {
        return @"BOOL";
    } else {
        NSArray *secondaryComponents = [firstComponent componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"@"]];

        NSString *firstSecondaryComponent = [secondaryComponents firstObject];

        if ([firstSecondaryComponent isEqualToString:@"T"]) {
            return [[secondaryComponents lastObject] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        }
    }

    return nil;
}

+ (NSDictionary*)propertyTypeDictionaryOfClass:(Class)klass {
    NSMutableDictionary *propertyMap = [NSMutableDictionary dictionary];

    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList(klass, &outCount);
    
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        const char *propName = property_getName(property);
        
        if(propName) {
            
            NSString *propertyName = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
            NSString *propertyType = [self propertyTypeStringOfProperty:property];
            [propertyMap setValue:propertyType forKey:propertyName];
        }
    }

    free(properties);
    
    return propertyMap;
}

@end
