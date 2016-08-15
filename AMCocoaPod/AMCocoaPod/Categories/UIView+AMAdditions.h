//
//  UIView+AMAdditions.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 04/09/14.
//  Copyright (c) 2014 Adap Mobile ApS. All rights reserved.
//

@interface UIView (AMAdditions)

typedef void (^ overlayTappedBlock)(void);

/***
 * Frame Additions
 */

- (void)move:(CGPoint)offset;
- (void)moveTo:(CGPoint)point;
- (void)resize:(CGSize)delta;
- (void)resizeTo:(CGSize)size;

- (void)move:(CGPoint)offset duration:(NSTimeInterval)duration animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)moveTo:(CGPoint)point duration:(NSTimeInterval)duration animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)resize:(CGSize)delta duration:(NSTimeInterval)duration animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)resizeTo:(CGSize)size duration:(NSTimeInterval)duration animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

- (void)setOriginX:(float)x y:(float)y;

- (void)resetOriginToTopLeft;
- (void)resetOriginToTopRight;

/***
 * Shadow Effect Additions
 */

- (void)addDefaultShadow;
- (void)addTinyShadow;
- (void)addSmallShadow;
- (void)addDefaultECSlideShadow;
- (void)addShadowWithOffset:(CGSize)offset color:(UIColor*)color radius:(CGFloat)radius opacity:(CGFloat)opacity path:(UIBezierPath*)path;
- (void)removeShadow;

/***
 * Animations Additions
 */

- (void)hideWithDuration:(CGFloat)duration animated:(BOOL)animated;
- (void)hideWithDuration:(CGFloat)duration animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)hideAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)hideAnimated:(BOOL)animated;
- (void)showWithDuration:(CGFloat)duration animated:(BOOL)animated alpha:(CGFloat)alpha completion:(void (^)(BOOL finished))completion;
- (void)showWithDuration:(CGFloat)duration animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)showAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)showAnimated:(BOOL)animated alpha:(CGFloat)alpha completion:(void (^)(BOOL finished))completion;
- (void)showAnimated:(BOOL)animated;
- (void)showAnimated:(BOOL)animated alpha:(CGFloat)alpha;

/***
 * Background Colors and Patterns Additions
 */

- (void)addGradientBackgroundWithColors:(NSArray*)colors;

/***
 * Ads the necessary constraints to make the view to fit its superview
 */

- (void)addConstraintsToFitSuperview;
- (void)addConstraintsToFitView:(UIView*)containerView;
- (void)addConstraintsToCenterOnSuperview;
- (void)addConstraintsToCenterOnView:(UIView*)containerView;

/***
 * Border Additions
 */

- (void)addBorderWithWidth:(CGFloat)width color:(UIColor*)color;
- (void)addThinBorderWithColor:(UIColor*)color;
- (void)addBorderWithColor:(UIColor*)color;
- (void)addThinBorder;
- (void)addBorderWithRandomColor;

/***
 * Corners Additions
 */

- (void)cornerRadius:(CGFloat)radius;

/***
 * Subviews
 */

- (void)addEquidistantSubviewsCenteredVertically:(NSArray*)contentViews;

/***
 * Image
 */

- (UIImage*)renderAsImage;

/***
 * Overlay
 */

- (void)showOverlayWithColor:(UIColor*)color opacity:(CGFloat)opacity animated:(BOOL)animated userInteractionEnabled:(BOOL)userInteractionEnabled;
- (void)showOverlayWithColor:(UIColor*)color opacity:(CGFloat)opacity animated:(BOOL)animated userInteractionEnabled:(BOOL)userInteractionEnabled blurred:(BOOL)blurred;
- (void)hideOverlay:(BOOL)animated;

- (void)addTapGestureRecognizerToOverlay:(overlayTappedBlock)block;
- (void)passPanGestureRecognizer:(UIPanGestureRecognizer*)panGesture;
- (void)invokeOverlayTappedAction:(id)sender;

/***
 * Nib
 */

+ (instancetype)initFromNibWithOwner:(id)owner;
+ (instancetype)initFromNib;

@end
