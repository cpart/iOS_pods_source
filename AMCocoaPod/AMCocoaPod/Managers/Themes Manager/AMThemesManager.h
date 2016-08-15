//
//  AMThemesManager.h
//  LO-Plus
//
//  Created by Raúl Pérez on 12/09/14.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kThemesInfoFileName @"Themes"
#define kThemesInfoFileExtension @"plist"
#define kDefaultThemeName @"Default"

#define kThemeColorsKeyName @"Colors"
#define kThemeImagesKeyName @"Images"
#define kThemeFontsKeyName @"Fonts"
#define kThemeSettingsKeyName @"Settings"
#define kThemeTextsKeyName @"Texts"
#define kThemeIconsKeyName @"Icons"
#define kThemeDataKeyName @"Data"

@interface AMThemesManager : NSObject

@property (nonatomic, getter = isDefaultTheme) BOOL defaultTheme;

+ (AMThemesManager*)sharedManager;

- (void)loadDefaultTheme;
- (void)loadTheme:(NSString*)themeName;

- (NSString*)imageNameWithGeneralName:(NSString*)imageName __deprecated;
- (NSString*)imageNameWithGeneralName:(NSString*)imageName forTheme:(NSString*)themeName __deprecated;
- (UIImage*)imageNamed:(NSString*)imageName __deprecated;
- (UIImage*)imageNamed:(NSString*)imageName forTheme:(NSString*)themeName __deprecated;
- (UIColor*)colorNamed:(NSString*)colorName __deprecated;
- (UIColor*)colorNamed:(NSString*)colorName forTheme:(NSString*)themeName __deprecated;
- (NSString*)colorHEX:(NSString*)colorName __deprecated;
- (NSString*)colorHEX:(NSString*)colorName forTheme:(NSString*)themeName __deprecated;
- (UIFont*)fontNamed:(NSString*)fontName size:(CGFloat)size __deprecated;
- (UIFont*)fontNamed:(NSString*)fontName size:(CGFloat)size forTheme:(NSString*)themeName __deprecated;
- (NSString*)settingNamed:(NSString*)settingName __deprecated;
- (NSString*)settingNamed:(NSString*)settingName forTheme:(NSString*)themeName __deprecated;
- (NSString*)textNamed:(NSString*)textName __deprecated;
- (NSString*)textNamed:(NSString*)textName forTheme:(NSString*)themeName __deprecated;
- (NSString*)iconCodeNamed:(NSString*)iconName __deprecated;
- (NSString*)iconCodeNamed:(NSString*)iconName forTheme:(NSString*)themeName __deprecated;
- (id)dataNamed:(NSString*)dataName __deprecated;
- (id)dataNamed:(NSString*)dataName forTheme:(NSString*)themeName __deprecated;

+ (void)loadDefaultTheme;
+ (void)loadTheme:(NSString*)themeName;
+ (NSString*)imageNameWithGeneralName:(NSString*)imageName;
+ (NSString*)imageNameWithGeneralName:(NSString*)imageName forTheme:(NSString*)themeName;
+ (UIImage*)imageNamed:(NSString*)imageName;
+ (UIImage*)imageNamed:(NSString*)imageName forTheme:(NSString*)themeName;
+ (UIColor*)colorNamed:(NSString*)colorName;
+ (UIColor*)colorNamed:(NSString*)colorName forTheme:(NSString*)themeName;
+ (NSString*)colorHEX:(NSString*)colorName;
+ (NSString*)colorHEX:(NSString*)colorName forTheme:(NSString*)themeName;
+ (UIFont*)fontNamed:(NSString*)fontName size:(CGFloat)size;
+ (UIFont*)fontNamed:(NSString*)fontName size:(CGFloat)size forTheme:(NSString*)themeName;
+ (NSString*)settingNamed:(NSString*)settingName;
+ (NSString*)settingNamed:(NSString*)settingName forTheme:(NSString*)themeName;
+ (NSString*)textNamed:(NSString*)textName;
+ (NSString*)textNamed:(NSString*)textName forTheme:(NSString*)themeName;
+ (NSString*)iconCodeNamed:(NSString*)iconName;
+ (NSString*)iconCodeNamed:(NSString*)iconName forTheme:(NSString*)themeName;
+ (NSString*)iconCodeStrippedNamed:(NSString*)iconName;
+ (NSString*)iconCodeStrippedNamed:(NSString*)iconName forTheme:(NSString*)themeName;
+ (id)dataNamed:(NSString*)dataName;
+ (id)dataNamed:(NSString*)dataName forTheme:(NSString*)themeName;

@end
