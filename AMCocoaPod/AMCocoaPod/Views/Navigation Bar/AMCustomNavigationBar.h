//
//  AMCustomNavigationBar.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 10/09/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AMGradientDirection) {
    AMVerticalGradient = 0,
    AMHorizontalGradient
};

@protocol AMCustomNavigationBarDelegate <NSObject>

- (void)didTapLogoImage:(id)sender;

@end

@interface AMCustomNavigationBar : UINavigationBar

@property (nonatomic) IBOutlet id<AMCustomNavigationBarDelegate> gestureRecognizersDelegate;

- (void)setLogoWithName:(NSString*)name;
- (void)setLogoWithImage:(UIImage*)logoImage;
- (void)showLogoAnimated:(BOOL)animate;
- (void)hideLogoAnimated:(BOOL)animate;
- (void)moveLogo:(CGPoint)point;
- (void)centerLogo;
- (void)pushDownLogo:(CGFloat)offset;
- (void)setBarTintGradientColors:(NSArray *)barTintGradientColors direction:(AMGradientDirection)direction;
- (void)removeGradientLayer;
- (void)addCustomView:(UIView*)customView;
- (void)removeCustomView;
- (void)addCustomBackgroundView:(UIView*)customBackgroundView;
- (void)removeCustomBackgroundView;
- (void)scaleLogo:(CGFloat)scale;

@end
