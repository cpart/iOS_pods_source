//
//  AMCustomNavigationBar.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 10/09/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import "AMCustomNavigationBar.h"
#import "UIView+AMAdditions.h"

static void * AMCustomNavigationBarContext = (void*)&AMCustomNavigationBarContext;

@interface AMCustomNavigationBar () <UIGestureRecognizerDelegate>

@property (nonatomic) NSString *logoImageName;
@property (nonatomic) CGSize logoImageSize;
@property (nonatomic) UIImageView *logoImageView;
@property (nonatomic) UIImage *logoImage;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic) UIView *customView;
@property (nonatomic) UIView *customBackgroundView;
@property (nonatomic) UITapGestureRecognizer *singleTapGestureRecognizer;
@property (nonatomic) BOOL overrideTitle;

- (void)initialize;
- (void)hideTitleText;

@end

@implementation AMCustomNavigationBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

- (void)initialize {
    self.singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureAction:)];
    [self.singleTapGestureRecognizer setNumberOfTapsRequired:1];
    [self.singleTapGestureRecognizer setDelegate:self];
    
    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:AMCustomNavigationBarContext];
    
    if (self.overrideTitle) {
        [self hideTitleText];
    }
    
    [self showLogoAnimated:YES];
}

- (void)dealloc {
    @try {
        [self removeObserver:self forKeyPath:@"frame" context:AMCustomNavigationBarContext];
    } @catch (NSException *exception) {}
    
    @try {
        [self.logoImageView removeGestureRecognizer:self.singleTapGestureRecognizer];
    } @catch (NSException *exception) {}
}

- (void)hideTitleText {
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor clearColor]}];
}

- (void)setLogoWithName:(NSString*)name {
    self.logoImageName = name;
    
    self.logoImage = [UIImage imageNamed:self.logoImageName];
    
    [self showLogoAnimated:YES];
}

- (void)setLogoWithImage:(UIImage*)logoImage {
    self.logoImage = logoImage;
    
    [self showLogoAnimated:YES];
}


- (void)showLogoAnimated:(BOOL)animate {
    if ((self.logoImageName && ![self.logoImageName isEqualToString:@""]) || (self.logoImage && self.singleTapGestureRecognizer)) {
        if (self.logoImageView != nil) {
            if (self.logoImageView.alpha == 0) {
                animate = YES;
            } else {
                animate = NO;
            }
            
            [self.logoImageView removeFromSuperview];
            self.logoImageView = nil;
            
            [self.logoImageView removeGestureRecognizer:self.singleTapGestureRecognizer];
        }
        
        self.logoImageView = [[UIImageView alloc] initWithImage:self.logoImage];
        self.logoImageSize = self.logoImage.size;
        
        self.logoImageView.alpha = 0.0f;
        
        CGRect imageViewFrame = self.logoImageView.frame;
        
        if (self.logoImageSize.width == 0 || self.logoImageSize.height == 0) {
            self.logoImageSize = self.logoImage.size;
        }
        
        self.logoImageView.frame = imageViewFrame;
        [self addSubview:self.logoImageView];
        
        [self centerLogo];
        
        if (animate) {
            [UIView animateWithDuration:0.5f animations:^{
                self.logoImageView.alpha = 1.0f;
            }];
        } else {
            self.logoImageView.alpha = 1.0f;
        }
        
        [self.logoImageView addGestureRecognizer:self.singleTapGestureRecognizer];
        [self.logoImageView setUserInteractionEnabled:YES];
    }
}

- (void)hideLogoAnimated:(BOOL)animate {
    [self.logoImageView hideAnimated:animate];
}

- (void)moveLogo:(CGPoint)point {
    [self.logoImageView move:point];
}

- (void)centerLogo {
    CGPoint logoImageViewCenter = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f);
    self.logoImageView.center = logoImageViewCenter;
}

- (void)pushDownLogo:(CGFloat)offset {
    CGPoint logoImageViewCenter = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f);
    logoImageViewCenter.y += offset;
    self.logoImageView.center = logoImageViewCenter;
}

static CGFloat const kDefaultOpacity = 0.5f;

- (void)setBarTintGradientColors:(NSArray *)barTintGradientColors direction:(AMGradientDirection)direction {
    // create the gradient layer
    if (self.gradientLayer == nil) {
        self.gradientLayer = [CAGradientLayer layer];
        
        if (direction == AMHorizontalGradient) {
            [self.gradientLayer setStartPoint:CGPointMake(0.0, 0.5)];
            [self.gradientLayer setEndPoint:CGPointMake(1.0, 0.5)];
        }
        
        self.gradientLayer.opacity = self.translucent ? kDefaultOpacity : 1.0f;
    } else {
        [self.gradientLayer setHidden:NO];
    }
    
    NSMutableArray * colors = nil;
    if (barTintGradientColors != nil)
    {
        colors = [NSMutableArray arrayWithCapacity:[barTintGradientColors count]];
        
        // determine elements in the array are colours
        // and add them to the colors array
        [barTintGradientColors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIColor class]])
            {
                // UIColor class
                [colors addObject:(id)[obj CGColor]];
            }
            else if ( CFGetTypeID( (__bridge void *)obj ) == CGColorGetTypeID() )
            {
                // CGColorRef
                [colors addObject:obj];
            }
            else
            {
                // obj is not a supported type
                @throw [NSException exceptionWithName:@"BarTintGraidentColorsError" reason:@"object in barTintGradientColors array is not a UIColor or CGColorRef" userInfo:nil];
            }
        }];
        
        // make it possible for the graident to be seen for iOS 6 and iOS 7
        if ( [self respondsToSelector:@selector(setBarTintColor:)] )
        {
            // iOS 7
            self.barTintColor = [UIColor clearColor];
        }
        else
        {
            // iOS 6
            self.tintColor = [UIColor clearColor];
            // stops the gradient on iOS 6 UINavigationBar
            [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        }
    }
    
    // set the graident colours to the laery
    self.gradientLayer.colors = colors;
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // allow all layout subviews call to adjust the frame
    if ( self.gradientLayer != nil )
    {
        if ( floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1 )
        {
            // iOS 7
            CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
            self.gradientLayer.frame = CGRectMake(0, 0 - statusBarHeight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + statusBarHeight);
        }
        else
        {
            // iOS 6
            self.gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        }
        
        // make sure the graident layer is at position 1
        [self.layer insertSublayer:self.gradientLayer atIndex:1];
    }
    
}

- (void)removeGradientLayer {
    [self.gradientLayer setHidden:YES];
}

- (void)addCustomView:(UIView*)customView {
    if (self.customView != nil) {
        [self.customView removeFromSuperview];
        self.customView = nil;
    }
    
    self.customView = customView;
    
    [self addSubview:self.customView];
}

- (void)removeCustomView {
    if (self.customView != nil) {
        [self.customView removeFromSuperview];
        self.customView = nil;
    }
}

- (void)addCustomBackgroundView:(UIView*)customBackgroundView {
    if (self.customBackgroundView != nil) {
        [self.customBackgroundView.layer removeFromSuperlayer];
        self.customBackgroundView = nil;
    }
    
    self.customBackgroundView = customBackgroundView;
    
    [self.layer insertSublayer:self.customBackgroundView.layer atIndex:1];
}

- (void)removeCustomBackgroundView {
    if (self.customBackgroundView != nil) {
        [self.customBackgroundView.layer removeFromSuperlayer];
        self.customBackgroundView = nil;
    }
}

- (void)scaleLogo:(CGFloat)scale{
    if (self.logoImageView) {
        CGRect currentFrame = self.logoImageView.frame;
        currentFrame = CGRectMake(currentFrame.origin.x, currentFrame.origin.y, currentFrame.size.width*scale, currentFrame.size.height*scale);
        CGPoint logoImageViewCenter = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f);
        self.logoImageView.frame = currentFrame;
        self.logoImageView.center = logoImageViewCenter;
    }
}

#pragma mark - UIGestureRecognizer

- (void)singleTapGestureAction:(id)sender {
    NSLog(@"singleTapGestureAction");
    
    if (self.gestureRecognizersDelegate && [self.gestureRecognizersDelegate conformsToProtocol:@protocol(AMCustomNavigationBarDelegate)]) {
        [self.gestureRecognizersDelegate didTapLogoImage:self];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (context == AMCustomNavigationBarContext && [keyPath isEqualToString:@"frame"]) {
        CGPoint logoImageViewCenter = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f);
        self.logoImageView.center = logoImageViewCenter;
    }
}

@end