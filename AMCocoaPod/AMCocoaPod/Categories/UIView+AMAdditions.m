//
//  UIView+AMAdditions.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 04/09/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

#import "UIView+AMAdditions.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import "UIColor+AMAdditions.h"

// Used to identify the associating glowing view
static char* GLOWVIEW_KEY = "GLOWVIEW";
static const void *OverlayViewKey = &OverlayViewKey;
static const void *OverlayTappedBlockKey = &OverlayTappedBlockKey;

@implementation UIView (AMAdditions)

#pragma mark - Frame Additions

- (void)move:(CGPoint)offset {
    CGRect frame = self.frame;
    
    if(ABS(offset.x) >= 1) {
        frame.origin.x += offset.x;
    }
    
    if(ABS(offset.y) >= 1) {
        frame.origin.y += offset.y;
    }
    
    self.frame = frame;
}

- (void)moveTo:(CGPoint)point {
    CGRect frame = self.frame;
    
    frame.origin.x = point.x;
    frame.origin.y = point.y;
    
    self.frame = frame;
}

- (void)resize:(CGSize)delta {
    CGRect frame = self.frame;
    
    frame.size.width += delta.width;
    frame.size.height += delta.height;
    
    self.frame = frame;
}

- (void)resizeTo:(CGSize)size {
    CGRect frame = self.frame;
    
    frame.size = size;
    
    self.frame = frame;
}

- (void)move:(CGPoint)offset duration:(NSTimeInterval)duration animated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    void (^animationsBlock)(void) = ^{
        [self move:offset];
    };
    
    if (animated) {
        [UIView animateWithDuration:duration animations:animationsBlock completion:completion];
    } else {
        animationsBlock();
    }
}

- (void)moveTo:(CGPoint)point duration:(NSTimeInterval)duration animated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    void (^animationsBlock)(void) = ^{
        [self moveTo:point];
    };
    
    if (animated) {
        [UIView animateWithDuration:duration animations:animationsBlock completion:completion];
    } else {
        animationsBlock();
    }
}

- (void)resize:(CGSize)delta duration:(NSTimeInterval)duration animated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    void (^animationsBlock)(void) = ^{
        [self resize:delta];
    };
    
    if (animated) {
        [UIView animateWithDuration:duration animations:animationsBlock completion:completion];
    } else {
        animationsBlock();
    }
}

- (void)resizeTo:(CGSize)size duration:(NSTimeInterval)duration animated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    void (^animationsBlock)(void) = ^{
        [self resizeTo:size];
    };
    
    if (animated) {
        [UIView animateWithDuration:duration animations:animationsBlock completion:completion];
    } else {
        animationsBlock();
    }
}

- (void)setOriginX:(float)x y:(float)y {
    self.layer.anchorPoint = CGPointMake(x, y);
}

- (void)resetOriginToTopLeft {
    [self setOriginX:CGRectGetMinX(self.frame) y:CGRectGetMinY(self.frame)];
    [self setCenter:CGPointMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame))];
}

- (void)resetOriginToTopRight {
    [self setOriginX:CGRectGetMaxX(self.frame) y:CGRectGetMinY(self.frame)];
    [self setCenter:CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMinY(self.frame))];
}

#pragma mark - Shadow Effect Additions

- (void)addDefaultShadow {
    CALayer *layer = self.layer;
    [self addShadowWithOffset:CGSizeMake(1.0f, 1.0f) color:[UIColor blackColor] radius:4.0f opacity:0.80f path:[UIBezierPath bezierPathWithRect:layer.bounds]];
}

- (void)addTinyShadow {
    CALayer *layer = self.layer;
    
    [self addShadowWithOffset:CGSizeMake(0.01f, 0.01f) color:[UIColor blackColor] radius:1.0f opacity:0.70f path:[UIBezierPath bezierPathWithRect:layer.bounds]];
}

- (void)addSmallShadow {
    CALayer *layer = self.layer;
    
    [self addShadowWithOffset:CGSizeMake(0.03f, 0.03f) color:[UIColor blackColor] radius:2.0f opacity:0.70f path:[UIBezierPath bezierPathWithRect:layer.bounds]];
}

- (void)addDefaultECSlideShadow {
    CALayer *layer = self.layer;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowRadius = 10.0f;
    layer.shadowOpacity = 0.75f;
}

- (void)addShadowWithOffset:(CGSize)offset color:(UIColor*)color radius:(CGFloat)radius opacity:(CGFloat)opacity path:(UIBezierPath*)path {
    CALayer *layer = self.layer;
    layer.shadowOffset = offset;
    layer.shadowColor = color.CGColor;
    layer.shadowRadius = radius;
    layer.shadowOpacity = opacity;
    
    if (![self isKindOfClass:[UITableView class]]) {
        layer.shadowPath = path.CGPath;
    }
}

- (void)removeShadow {
    CALayer *layer = self.layer;
    layer.shadowOpacity = 0.0f;
    layer.shadowPath = nil;
}

#pragma mark - Animations

- (void)hideWithDuration:(CGFloat)duration animated:(BOOL)animated {
    [self hideWithDuration:duration animated:animated completion:^(BOOL finished) {
    }];
}

- (void)hideWithDuration:(CGFloat)duration animated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    void (^refreshBlock)(void) = ^{
        self.alpha = 0.0f;
    };
    
    if (animated) {
        [UIView animateWithDuration:duration animations:refreshBlock completion:completion];
    } else {
        refreshBlock();
    }
}

- (void)hideAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    [self hideWithDuration:0.5f animated:animated completion:completion];
}

- (void)hideAnimated:(BOOL)animated {
    [self hideWithDuration:0.5f animated:animated completion:^(BOOL finished) {
    }];
}

- (void)showWithDuration:(CGFloat)duration animated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    [self showWithDuration:0.5f animated:animated alpha:1.0f completion:completion];
}

- (void)showWithDuration:(CGFloat)duration animated:(BOOL)animated alpha:(CGFloat)alpha completion:(void (^)(BOOL finished))completion {
    void (^refreshBlock)(void) = ^{
        self.alpha = alpha;
    };
    
    if (animated) {
        [UIView animateWithDuration:duration animations:refreshBlock completion:completion];
    } else {
        refreshBlock();
    }
}

- (void)showAnimated:(BOOL)animated alpha:(CGFloat)alpha completion:(void (^)(BOOL finished))completion {
    [self showWithDuration:0.5f animated:animated alpha:alpha completion:completion];
}

- (void)showAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    [self showWithDuration:0.5f animated:animated completion:completion];
}

- (void)showAnimated:(BOOL)animated alpha:(CGFloat)alpha {
    [self showWithDuration:0.5f animated:animated alpha:alpha completion:^(BOOL finished) {
    }];
}

- (void)showAnimated:(BOOL)animated {
    [self showAnimated:animated alpha:1.0f];
}

#pragma mark - Background Colors and Patterns

- (void)addGradientBackgroundWithColors:(NSArray*)colors {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = colors;
    [self.layer insertSublayer:gradient atIndex:0];
}

#pragma mark - Glow Effects Additions

// Get the glowing view attached to this one.
- (UIView*) glowView {
    return objc_getAssociatedObject(self, GLOWVIEW_KEY);
}

// Attach a view to this one, which we'll use as the glowing view.
- (void) setGlowView:(UIView*)glowView {
    objc_setAssociatedObject(self, GLOWVIEW_KEY, glowView, OBJC_ASSOCIATION_RETAIN);
}

- (void)startGlowingWithColor:(UIColor *)color intensity:(CGFloat)intensity {
    [self startGlowingWithColor:color fromIntensity:0.1 toIntensity:intensity repeat:YES];
}

- (void) startGlowingWithColor:(UIColor*)color fromIntensity:(CGFloat)fromIntensity toIntensity:(CGFloat)toIntensity repeat:(BOOL)repeat {
    
    // If we're already glowing, don't bother
    if ([self glowView])
        return;
    
    // The glow image is taken from the current view's appearance.
    // As a side effect, if the view's content, size or shape changes,
    // the glow won't update.
    UIImage* image;
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale); {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIBezierPath* path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        
        [color setFill];
        
        [path fillWithBlendMode:kCGBlendModeSourceAtop alpha:1.0];
        
        
        image = UIGraphicsGetImageFromCurrentImageContext();
    } UIGraphicsEndImageContext();
    
    // Make the glowing view itself, and position it at the same
    // point as ourself. Overlay it over ourself.
    UIView* glowView = [[UIImageView alloc] initWithImage:image];
    glowView.center = self.center;
    [self.superview insertSubview:glowView aboveSubview:self];
    
    // We don't want to show the image, but rather a shadow created by
    // Core Animation. By setting the shadow to white and the shadow radius to
    // something large, we get a pleasing glow.
    glowView.alpha = 0;
    glowView.layer.shadowColor = color.CGColor;
    glowView.layer.shadowOffset = CGSizeZero;
    glowView.layer.shadowRadius = 10;
    glowView.layer.shadowOpacity = 1.0;
    
    // Create an animation that slowly fades the glow view in and out forever.
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @(fromIntensity);
    animation.toValue = @(toIntensity);
    animation.repeatCount = repeat ? HUGE_VAL : 0;
    animation.duration = 1.0;
    animation.autoreverses = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [glowView.layer addAnimation:animation forKey:@"pulse"];
    
    // Finally, keep a reference to this around so it can be removed later
    [self setGlowView:glowView];
}

- (void) glowOnceAtLocation:(CGPoint)point inView:(UIView*)view {
    [self startGlowingWithColor:[UIColor whiteColor] fromIntensity:0 toIntensity:0.6 repeat:NO];
    
    [self glowView].center = point;
    [view addSubview:[self glowView]];
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self stopGlowing];
    });
}

- (void)glowOnce {
    [self startGlowing];
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self stopGlowing];
    });
    
}

// Create a pulsing, glowing view based on this one.
- (void) startGlowing {
    [self startGlowingWithColor:[UIColor whiteColor] intensity:0.6];
}

// Stop glowing by removing the glowing view from the superview and removing the association between it and this object.
- (void) stopGlowing {
    [[self glowView] removeFromSuperview];
    [self setGlowView:nil];
}

#pragma mark - Constraints

- (void)addConstraintsToFitSuperview {
    [self addConstraintsToFitView:self.superview];
}

- (void)addConstraintsToFitView:(UIView*)containerView {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:0.0]];
    
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeLeading
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeLeading
                                                             multiplier:1.0
                                                               constant:0.0]];
    
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0.0]];
    
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeTrailing
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeTrailing
                                                             multiplier:1.0
                                                               constant:0.0]];
    
    [containerView layoutIfNeeded];
}

- (void)addConstraintsToCenterOnSuperview {
    [self addConstraintsToCenterOnView:self.superview];
}

- (void)addConstraintsToCenterOnView:(UIView*)containerView {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeCenterX
                                                             multiplier:1.0
                                                               constant:0.0]];
    
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeCenterY
                                                             multiplier:1.0
                                                               constant:0.0]];
    
    [containerView layoutIfNeeded];
}

#pragma mark - Borders Additions

- (void)addBorderWithWidth:(CGFloat)width color:(UIColor*)color {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

- (void)addThinBorderWithColor:(UIColor*)color {
    [self addBorderWithWidth:0.5f color:color];
}

- (void)addBorderWithColor:(UIColor*)color {
    [self addBorderWithWidth:1.0f color:color];
}

- (void)addThinBorder {
    [self addThinBorderWithColor:[UIColor blackColor]];
}

- (void)addBorderWithRandomColor {
    [self addBorderWithColor:[UIColor randomColor]];
}

#pragma mark - Corners Additions

- (void)cornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
}

#pragma mark - Subviews

- (void)addEquidistantSubviewsCenteredVertically:(NSArray*)contentViews {
    self.autoresizesSubviews = NO;
    
    if (contentViews.count == 0) {
        return;
    }
    
    NSMutableArray *allSubviews = [NSMutableArray array];
    NSMutableArray *supportViews = [NSMutableArray array];
    
    for (UIView *currentContentView in contentViews) {
        UIView *currentSupportView = [UIView new];
        
        [currentSupportView setTranslatesAutoresizingMaskIntoConstraints:NO];
        currentSupportView.backgroundColor = [UIColor clearColor];
        
        [supportViews addObject:currentSupportView];
        [self addSubview:currentSupportView];
        
        [allSubviews addObject:currentSupportView];
        
        [currentContentView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:currentContentView];
        
        [allSubviews addObject:currentContentView];
    }
    
    UIView *lastSupportView = [UIView new];
    
    [lastSupportView setTranslatesAutoresizingMaskIntoConstraints:NO];
    lastSupportView.backgroundColor = [UIColor clearColor];
    
    [supportViews addObject:lastSupportView];
    [allSubviews addObject:lastSupportView];
    
    [self addSubview:lastSupportView];
    
    for (NSInteger i = 0; i < allSubviews.count; i++) {
        UIView *currentContentView = allSubviews[i];
        UIView *previousView = nil;
        UIView *nextView = nil;
        
        CGRect currentViewFrame = currentContentView.frame;
        
        NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:currentContentView.frame.size.width];
        NSLayoutConstraint *equalsWidthConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:[allSubviews firstObject] attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f];
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0f constant:currentViewFrame.size.height];
        
        if (i == 0) {
            
            NSLayoutConstraint *firstPageLeadingConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0];
            
            if (allSubviews.count == 1) {
                NSLayoutConstraint *firstPageTrailingConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
                [self addConstraint:firstPageTrailingConstraint];
            }
            
            [self addConstraint:firstPageLeadingConstraint];
        } else if (i == allSubviews.count - 1) {
            previousView = allSubviews[i - 1];
            
            NSLayoutConstraint *lastPageLeadingConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:previousView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
            NSLayoutConstraint *lastPageTrailingConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
            
            [self addConstraint:lastPageLeadingConstraint];
            [self addConstraint:lastPageTrailingConstraint];
        } else {
            previousView = allSubviews[i - 1];
            nextView = allSubviews[i + 1];
            
            NSLayoutConstraint *intermediatePageLeadingConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:previousView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
            NSLayoutConstraint *intermediatePageTrailingConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:nextView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0];
            
            [self addConstraint:intermediatePageLeadingConstraint];
            [self addConstraint:intermediatePageTrailingConstraint];
        }
        
        if ((i % 2) == 0) {
            currentContentView.backgroundColor = [UIColor cyanColor];
            if (i > 0) {
                [self addConstraint:equalsWidthConstraint];
            }
        } else {
            [self addConstraint:widthConstraint];
        }
        
        [self addConstraint:centerYConstraint];
        [self addConstraint:heightConstraint];
    }
}

#pragma mark - Image

- (UIImage*)renderAsImage {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
    [[self layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - Overlay

- (void)setOverlay:(UIView *)overlayView {
    objc_setAssociatedObject(self, OverlayViewKey, overlayView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView*)overlayView {
    return objc_getAssociatedObject(self, OverlayViewKey);
}

- (void)setOverlayTappedBlock:(overlayTappedBlock)overlayTappedBlock {
    objc_setAssociatedObject(self, OverlayTappedBlockKey, overlayTappedBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (overlayTappedBlock)overlayTappedBlock {
    return objc_getAssociatedObject(self, OverlayTappedBlockKey);
}


- (void)showOverlayWithColor:(UIColor*)color opacity:(CGFloat)opacity animated:(BOOL)animated userInteractionEnabled:(BOOL)userInteractionEnabled {
    
    [self showOverlayWithColor:color opacity:opacity animated:animated userInteractionEnabled:userInteractionEnabled blurred:NO];
}

- (void)showOverlayWithColor:(UIColor*)color opacity:(CGFloat)opacity animated:(BOOL)animated userInteractionEnabled:(BOOL)userInteractionEnabled blurred:(BOOL)blurred {
    
    CGRect parentBounds = self.bounds;
    
    UIView *overlayViewTemp = [self overlayView];
    
    if (overlayViewTemp == nil) {
        if (blurred) {
            UIVisualEffect *blurEffect;
            blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            overlayViewTemp = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            overlayViewTemp.frame = CGRectMake(0.0f, 0.0f, parentBounds.size.width, parentBounds.size.height);
        } else {
            overlayViewTemp = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, parentBounds.size.width, parentBounds.size.height)];
        }

        [self setOverlay:overlayViewTemp];
    }
    
    overlayViewTemp.alpha = 0.0f;
    overlayViewTemp.backgroundColor = color;
    overlayViewTemp.userInteractionEnabled = userInteractionEnabled;
    
    [self addSubview:overlayViewTemp];
    [self bringSubviewToFront:overlayViewTemp];
    
    if (animated) {
        [UIView animateWithDuration:0.20f animations:^{
            overlayViewTemp.alpha =  opacity;
        }];
    } else {
        overlayViewTemp.alpha = opacity;
    }
}

- (void)hideOverlay:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.1f animations:^{
            self.overlayView.alpha =  0.0f;
        } completion:^(BOOL finished) {
            [self.overlayView removeFromSuperview];
        }];
    } else {
        [self.overlayView removeFromSuperview];
    }
}

- (void)addTapGestureRecognizerToOverlay:(overlayTappedBlock)block {
    if (self.overlayView) {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(invokeOverlayTappedAction:)];
        self.overlayTappedBlock = block;
        [self.overlayView addGestureRecognizer:tapGestureRecognizer];
    }
}

- (void)passPanGestureRecognizer:(UIPanGestureRecognizer*)panGesture {
    if (self.overlayView) {
        [self.overlayView addGestureRecognizer:panGesture];
    }
}

- (void)invokeOverlayTappedAction:(id)sender {
    [self overlayTappedBlock]();
}

#pragma mark - Nib

+ (instancetype)initFromNibWithOwner:(id)owner {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:owner options:nil] firstObject];
}

+ (instancetype)initFromNib {
    return [self initFromNibWithOwner:nil];
}

@end
