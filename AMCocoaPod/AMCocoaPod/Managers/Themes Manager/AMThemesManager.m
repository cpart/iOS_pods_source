//
//  AMThemesManager.m
//  LO-Plus
//
//  Created by Raúl Pérez on 12/09/14.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import "AMThemesManager.h"
#import "UIColor+AMAdditions.h"

@interface AMThemesManager ()

@property (nonatomic) AMThemesManager *sharedManager;

@property (nonatomic) NSDictionary *themes;

@property (nonatomic, strong) NSDictionary *currentThemeName;
@property (nonatomic, strong) NSDictionary *currentTheme;
@property (nonatomic, strong) NSDictionary *currentThemeColors;
@property (nonatomic, strong) NSDictionary *currentThemeImages;
@property (nonatomic, strong) NSDictionary *currentThemeFonts;
@property (nonatomic, strong) NSDictionary *currentThemeSettings;
@property (nonatomic, strong) NSDictionary *currentThemeTexts;
@property (nonatomic, strong) NSDictionary *currentThemeIcons;
@property (nonatomic, strong) NSDictionary *currentThemeData;

@end

@implementation AMThemesManager

- (id)init {
    self = [super init];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

+ (AMThemesManager*)sharedManager {
    static AMThemesManager *sharedTransitionDelegate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTransitionDelegate = [[AMThemesManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedTransitionDelegate;
}

- (void)initialize {
    NSString *themesPlistFilePath = [[NSBundle mainBundle] pathForResource:kThemesInfoFileName ofType:kThemesInfoFileExtension];
    self.themes = [NSDictionary dictionaryWithContentsOfFile:themesPlistFilePath];
    [self loadTheme:kDefaultThemeName];
}

- (void)loadDefaultTheme {
    self.defaultTheme = YES;
    [self loadTheme:kDefaultThemeName];
}

- (void)loadTheme:(NSString*)themeName {
    if ([themeName isEqualToString:kDefaultThemeName]) {
        self.defaultTheme = YES;
    } else {
        self.defaultTheme = NO;
    }
    
    self.currentThemeName = [themeName copy];
    self.currentTheme = [self.themes objectForKey:themeName];
    self.currentThemeColors = [self.currentTheme objectForKey:kThemeColorsKeyName];
    self.currentThemeImages = [self.currentTheme objectForKey:kThemeImagesKeyName];
    self.currentThemeFonts = [self.currentTheme objectForKey:kThemeFontsKeyName];
    self.currentThemeSettings = [self.currentTheme objectForKey:kThemeSettingsKeyName];
    self.currentThemeTexts = [self.currentTheme objectForKey:kThemeTextsKeyName];
    self.currentThemeIcons = [self.currentTheme objectForKey:kThemeIconsKeyName];
    self.currentThemeData = [self.currentTheme objectForKey:kThemeDataKeyName];
}

- (NSString*)imageNameWithGeneralName:(NSString*)imageName {
    return [self.currentThemeImages objectForKey:imageName];
}

- (NSString*)imageNameWithGeneralName:(NSString*)imageName forTheme:(NSString*)themeName {
    NSDictionary *themeTemp = [self.themes objectForKey:themeName];
    NSDictionary *themeImagesTemp = [themeTemp objectForKey:kThemeImagesKeyName];
    return [themeImagesTemp objectForKey:imageName];
}

- (UIImage*)imageNamed:(NSString*)imageName {
    NSString *imageNameForDefaultTheme = [self.currentThemeImages objectForKey:imageName];
    return [UIImage imageNamed:imageNameForDefaultTheme];
}

- (UIImage*)imageNamed:(NSString*)imageName forTheme:(NSString*)themeName {
    NSDictionary *themeTemp = [self.themes objectForKey:themeName];
    NSDictionary *themeImagesTemp = [themeTemp objectForKey:kThemeImagesKeyName];
    NSString *imageNameForThemeTemp = [themeImagesTemp objectForKey:imageName];
    
    return [UIImage imageNamed:imageNameForThemeTemp];
}

- (UIColor*)colorNamed:(NSString*)colorName {
    NSString *colorHexForDefaultTheme = [self.currentThemeColors objectForKey:colorName];
    return [UIColor colorWithHexString:colorHexForDefaultTheme];
}

- (UIColor*)colorNamed:(NSString*)colorName forTheme:(NSString*)themeName {
    NSDictionary *themeTemp = [self.themes objectForKey:themeName];
    NSDictionary *themeColorsTemp = [themeTemp objectForKey:kThemeColorsKeyName];
    NSString *colorHexForThemeTemp = [themeColorsTemp objectForKey:colorName];
    
    return [UIColor colorWithHexString:colorHexForThemeTemp];
}

- (NSString*)colorHEX:(NSString*)colorName {
    NSString *colorHexForDefaultTheme = [self.currentThemeColors objectForKey:colorName];
    return colorHexForDefaultTheme;
}

- (NSString*)colorHEX:(NSString*)colorName forTheme:(NSString*)themeName {
    NSDictionary *themeTemp = [self.themes objectForKey:themeName];
    NSDictionary *themeColorsTemp = [themeTemp objectForKey:kThemeColorsKeyName];
    NSString *colorHexForThemeTemp = [themeColorsTemp objectForKey:colorName];
    
    return colorHexForThemeTemp;
}

- (UIFont*)fontNamed:(NSString*)fontName size:(CGFloat)size {
    NSString *fontNameForDefaultTheme = [self.currentThemeFonts objectForKey:fontName];
    return [UIFont fontWithName:fontNameForDefaultTheme size:size];
}

- (UIFont*)fontNamed:(NSString*)fontName size:(CGFloat)size forTheme:(NSString*)themeName {
    NSDictionary *themeTemp = [self.themes objectForKey:themeName];
    NSDictionary *themeFontsTemp = [themeTemp objectForKey:kThemeFontsKeyName];
    NSString *fontNameForThemeTemp = [themeFontsTemp objectForKey:fontName];
    
    return [UIFont fontWithName:fontNameForThemeTemp size:size];
}

- (NSString*)settingNamed:(NSString*)settingName {
    NSString *settingForDefaultTheme = [self.currentThemeSettings objectForKey:settingName];
    return settingForDefaultTheme;
}

- (NSString*)settingNamed:(NSString*)settingName forTheme:(NSString*)themeName {
    NSDictionary *themeTemp = [self.themes objectForKey:themeName];
    NSDictionary *themeSettingsTemp = [themeTemp objectForKey:kThemeSettingsKeyName];
    NSString *settingForThemeTemp = [themeSettingsTemp objectForKey:settingName];
    
    return settingForThemeTemp;
}

- (NSString*)textNamed:(NSString*)textName {
    NSString *textForTheme = [self.currentThemeTexts objectForKey:textName];
    
    return textForTheme;
}

- (NSString*)textNamed:(NSString*)textName forTheme:(NSString*)themeName {
    NSDictionary *themeTemp = [self.themes objectForKey:themeName];
    NSDictionary *themeTextsTemp = [themeTemp objectForKey:kThemeTextsKeyName];
    NSString *textForThemeTemp = [themeTextsTemp objectForKey:textName];
    
    return textForThemeTemp;
}

- (NSString*)iconCodeNamed:(NSString*)iconName {
    NSString *iconCodeForDefaultTheme = [NSString stringWithCString:[[self.currentThemeIcons objectForKey:iconName] cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return iconCodeForDefaultTheme;
}

- (NSString*)iconCodeNamed:(NSString*)iconName forTheme:(NSString*)themeName {
    NSDictionary *themeTemp = [self.themes objectForKey:themeName];
    NSDictionary *themeIconsTemp = [themeTemp objectForKey:kThemeIconsKeyName];
    NSString *iconCodeForThemeTemp = [NSString stringWithCString:[[themeIconsTemp objectForKey:iconName] cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    
    return iconCodeForThemeTemp;
}

+ (NSString*)iconCodeStrippedNamed:(NSString*)iconName {
    NSAssert(iconName != nil, @"The name of the icon you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSAssert([currentManager.currentThemeIcons objectForKey:iconName], @"Could not find the expected icon with name '%@' from the AMThemesManager because doen't exist.", iconName);
    
    return [currentManager.currentThemeIcons objectForKey:iconName];
}

+ (NSString*)iconCodeStrippedNamed:(NSString*)iconName forTheme:(NSString*)themeName {
    NSAssert(iconName != nil, @"The name of the icon you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSDictionary *themeTemp = [currentManager.themes objectForKey:themeName];
    
    NSDictionary *themeIconsTemp = [themeTemp objectForKey:kThemeIconsKeyName];
    
    NSAssert([themeIconsTemp objectForKey:iconName], @"Could not find the expected icon with name '%@' from the AMThemesManager because doen't exist.", iconName);
    
    return [themeIconsTemp objectForKey:iconName];
}

- (id)dataNamed:(NSString*)dataName {
    NSString *dataForDefaultTheme = [self.currentThemeData objectForKey:dataName];
    return dataForDefaultTheme;
}

- (id)dataNamed:(NSString*)dataName forTheme:(NSString*)themeName {
    NSDictionary *themeTemp = [self.themes objectForKey:themeName];
    NSDictionary *themeDataTemp = [themeTemp objectForKey:kThemeDataKeyName];
    NSString *dataForThemeTemp = [themeDataTemp objectForKey:dataName];
    
    return dataForThemeTemp;
}

/* *************** Static Methods ********************** */

+ (void)loadDefaultTheme {
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    currentManager.defaultTheme = YES;
    [currentManager loadTheme:kDefaultThemeName];
}

+ (void)loadTheme:(NSString*)themeName {
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    if ([themeName isEqualToString:kDefaultThemeName]) {
        currentManager.defaultTheme = YES;
    } else {
        currentManager.defaultTheme = NO;
    }
    
    currentManager.currentThemeName = [themeName copy];
    currentManager.currentTheme = [currentManager.themes objectForKey:themeName];
    currentManager.currentThemeColors = [currentManager.currentTheme objectForKey:kThemeColorsKeyName];
    currentManager.currentThemeImages = [currentManager.currentTheme objectForKey:kThemeImagesKeyName];
    currentManager.currentThemeFonts = [currentManager.currentTheme objectForKey:kThemeFontsKeyName];
    currentManager.currentThemeSettings = [currentManager.currentTheme objectForKey:kThemeSettingsKeyName];
    currentManager.currentThemeTexts = [currentManager.currentTheme objectForKey:kThemeTextsKeyName];
    currentManager.currentThemeIcons = [currentManager.currentTheme objectForKey:kThemeIconsKeyName];
}

+ (NSString*)imageNameWithGeneralName:(NSString*)imageName {
    NSAssert(imageName != nil, @"The name of the image you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSAssert([currentManager.currentThemeImages objectForKey:imageName], @"Could not find the expected image with name '%@' from the AMThemesManager because doen't exist.", imageName);
    
    return [currentManager.currentThemeImages objectForKey:imageName];
}

+ (NSString*)imageNameWithGeneralName:(NSString*)imageName forTheme:(NSString*)themeName {
    NSAssert(imageName != nil, @"The name of the image you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSDictionary *themeTemp = [currentManager.themes objectForKey:themeName];
    
    NSAssert([themeTemp objectForKey:kThemeImagesKeyName], @"Could not find the expected image with name '%@' from the AMThemesManager because doen't exist.", imageName);
    
    NSDictionary *themeImagesTemp = [themeTemp objectForKey:kThemeImagesKeyName];
    
    return [themeImagesTemp objectForKey:imageName];
}

+ (UIImage*)imageNamed:(NSString*)imageName {
    NSAssert(imageName != nil, @"The name of the image you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSAssert([currentManager.currentThemeImages objectForKey:imageName], @"Could not find the expected image with name '%@' from the AMThemesManager because doen't exist.", imageName);
    
    NSString *imageNameForDefaultTheme = [currentManager.currentThemeImages objectForKey:imageName];
    
    return [UIImage imageNamed:imageNameForDefaultTheme];
}

+ (UIImage*)imageNamed:(NSString*)imageName forTheme:(NSString*)themeName {
    NSAssert(imageName != nil, @"The name of the image you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSDictionary *themeTemp = [currentManager.themes objectForKey:themeName];
    
    NSDictionary *themeImagesTemp = [themeTemp objectForKey:kThemeImagesKeyName];
    
    NSAssert([themeImagesTemp objectForKey:imageName], @"Could not find the expected image with name '%@' from the AMThemesManager because doen't exist.", imageName);
    
    NSString *imageNameForThemeTemp = [themeImagesTemp objectForKey:imageName];
    
    return [UIImage imageNamed:imageNameForThemeTemp];
}

+ (UIColor*)colorNamed:(NSString*)colorName {
    NSAssert(colorName != nil, @"The name of the color you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSAssert([currentManager.currentThemeColors objectForKey:colorName], @"Could not find the expected color with name '%@' from the AMThemesManager because doen't exist.", colorName);
    
    NSString *colorHexForDefaultTheme = [currentManager.currentThemeColors objectForKey:colorName];
    
    return [UIColor colorWithHexString:colorHexForDefaultTheme];
}

+ (UIColor*)colorNamed:(NSString*)colorName forTheme:(NSString*)themeName {
    NSAssert(colorName != nil, @"The name of the color you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSDictionary *themeTemp = [currentManager.themes objectForKey:themeName];
    
    NSDictionary *themeColorsTemp = [themeTemp objectForKey:kThemeColorsKeyName];
    
    NSAssert([themeColorsTemp objectForKey:colorName], @"Could not find the expected color with name '%@' from the AMThemesManager because doen't exist.", colorName);
    
    NSString *colorHexForThemeTemp = [themeColorsTemp objectForKey:colorName];
    
    return [UIColor colorWithHexString:colorHexForThemeTemp];
}

+ (NSString*)colorHEX:(NSString*)colorName {
    NSAssert(colorName != nil, @"The hex string of the color you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSAssert([currentManager.currentThemeColors objectForKey:colorName], @"Could not find the expected color with the hex '%@' from the AMThemesManager because doen't exist.", colorName);
    
    NSString *colorHexForDefaultTheme = [currentManager.currentThemeColors objectForKey:colorName];
    
    return colorHexForDefaultTheme;
}

+ (NSString*)colorHEX:(NSString*)colorName forTheme:(NSString*)themeName {
    NSAssert(colorName != nil, @"The name of the color you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSDictionary *themeTemp = [currentManager.themes objectForKey:themeName];
    NSDictionary *themeColorsTemp = [themeTemp objectForKey:kThemeColorsKeyName];
    
    NSAssert([themeColorsTemp objectForKey:colorName], @"Could not find the expected color with name '%@' from the AMThemesManager because doen't exist.", colorName);
    
    NSString *colorHexForThemeTemp = [themeColorsTemp objectForKey:colorName];
    
    return colorHexForThemeTemp;
}

+ (UIFont*)fontNamed:(NSString*)fontName size:(CGFloat)size {
    NSAssert(fontName != nil, @"The name of the font you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSAssert([currentManager.currentThemeFonts objectForKey:fontName], @"Could not find the expected font with name '%@' from the AMThemesManager because doen't exist.", fontName);
    
    NSString *fontNameForDefaultTheme = [currentManager.currentThemeFonts objectForKey:fontName];
    
    return [UIFont fontWithName:fontNameForDefaultTheme size:size];
}

+ (UIFont*)fontNamed:(NSString*)fontName size:(CGFloat)size forTheme:(NSString*)themeName {
    NSAssert(fontName != nil, @"The name of the font you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSDictionary *themeTemp = [currentManager.themes objectForKey:themeName];
    
    NSDictionary *themeFontsTemp = [themeTemp objectForKey:kThemeFontsKeyName];
    
    NSAssert([themeFontsTemp objectForKey:fontName], @"Could not find the expected font with name '%@' from the AMThemesManager because doen't exist.", fontName);
    
    NSString *fontNameForThemeTemp = [themeFontsTemp objectForKey:fontName];
    
    return [UIFont fontWithName:fontNameForThemeTemp size:size];
}

+ (NSString*)settingNamed:(NSString*)settingName {
    NSAssert(settingName != nil, @"The name of the setting you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSAssert([currentManager.currentThemeSettings objectForKey:settingName], @"Could not find the expected setting with name '%@' from the AMThemesManager because doen't exist.", settingName);
    
    NSString *settingForDefaultTheme = [currentManager.currentThemeSettings objectForKey:settingName];
    
    return settingForDefaultTheme;
}

+ (NSString*)settingNamed:(NSString*)settingName forTheme:(NSString*)themeName {
    NSAssert(settingName != nil, @"The name of the setting you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSDictionary *themeTemp = [currentManager.themes objectForKey:themeName];
    
    NSDictionary *themeSettingsTemp = [themeTemp objectForKey:kThemeSettingsKeyName];
    
    NSAssert([themeSettingsTemp objectForKey:settingName], @"Could not find the expected setting with name '%@' from the AMThemesManager because doen't exist.", settingName);
    
    NSString *settingForThemeTemp = [themeSettingsTemp objectForKey:settingName];
    
    return settingForThemeTemp;
}

+ (NSString*)textNamed:(NSString*)textName {
    NSAssert(textName != nil, @"The name of the text you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSAssert([currentManager.currentThemeTexts objectForKey:textName], @"Could not find the expected text with name '%@' from the AMThemesManager because doen't exist.", textName);
    
    NSString *textForDefaultTheme = [currentManager.currentThemeTexts objectForKey:textName];
    
    return textForDefaultTheme;
}

+ (NSString*)textNamed:(NSString*)textName forTheme:(NSString*)themeName {
    NSAssert(textName != nil, @"The name of the text you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSDictionary *themeTemp = [currentManager.themes objectForKey:themeName];
    
    NSDictionary *themeTextsTemp = [themeTemp objectForKey:kThemeTextsKeyName];
    
    NSAssert([themeTextsTemp objectForKey:textName], @"Could not find the expected text with name '%@' from the AMThemesManager because doen't exist.", textName);
    
    NSString *textForThemeTemp = [themeTextsTemp objectForKey:textName];
    
    return textForThemeTemp;
}

+ (NSString*)iconCodeNamed:(NSString*)iconName {
    NSAssert(iconName != nil, @"The name of the icon you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSAssert([currentManager.currentThemeIcons objectForKey:iconName], @"Could not find the expected icon with name '%@' from the AMThemesManager because doen't exist.", iconName);
    
    NSString *iconCodeForDefaultTheme = [NSString stringWithCString:[[currentManager.currentThemeIcons objectForKey:iconName] cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    
    return iconCodeForDefaultTheme;
}

+ (NSString*)iconCodeNamed:(NSString*)iconName forTheme:(NSString*)themeName {
    NSAssert(iconName != nil, @"The name of the icon you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSDictionary *themeTemp = [currentManager.themes objectForKey:themeName];
    
    NSDictionary *themeIconsTemp = [themeTemp objectForKey:kThemeIconsKeyName];
    
    NSAssert([themeIconsTemp objectForKey:iconName], @"Could not find the expected icon with name '%@' from the AMThemesManager because doen't exist.", iconName);
    
    NSString *iconCodeForThemeTemp = [NSString stringWithCString:[[themeIconsTemp objectForKey:iconName] cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    
    return iconCodeForThemeTemp;
}

+ (id)dataNamed:(NSString*)dataName {
    NSAssert(dataName != nil, @"The name of the data you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSAssert([currentManager.currentThemeData objectForKey:dataName], @"Could not find the expected data with name '%@' from the AMThemesManager because doen't exist.", dataName);
    
    NSString *dataForDefaultTheme = [currentManager.currentThemeData objectForKey:dataName];
    
    return dataForDefaultTheme;
}

+ (id)dataNamed:(NSString*)dataName forTheme:(NSString*)themeName {
    NSAssert(dataName != nil, @"The name of the data you are trying to retrieve is nil.");
    
    AMThemesManager *currentManager = [AMThemesManager sharedManager];
    
    NSDictionary *themeTemp = [currentManager.themes objectForKey:themeName];
    
    NSDictionary *themeDataTemp = [themeTemp objectForKey:kThemeDataKeyName];
    
    NSAssert([themeDataTemp objectForKey:dataName], @"Could not find the expected data with name '%@' from the AMThemesManager because doen't exist.", dataName);
    
    NSString *dataForThemeTemp = [themeDataTemp objectForKey:dataName];
    
    return dataForThemeTemp;
}

@end
