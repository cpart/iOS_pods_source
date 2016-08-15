//
//  AnimatedTableCell.h
//  Animated Table
//
//  Created by Philip Yu on 4/18/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AMAnimatedTableCellDirections) {
    AMAnimatedTableCellDirectionNone,
    AMAnimatedTableCellDirectionUp,
    AMAnimatedTableCellDirectionDown,
    AMAnimatedTableCellDirectionLeft,
    AMAnimatedTableCellDirectionRight
};

@interface AMAnimatedTableViewCell : UITableViewCell

@property (nonatomic) BOOL popped;
@property (strong, nonatomic) UIView *animatedContentView;

- (void)resetPosition;
- (void)configureCellContentSizeWidth:(CGFloat) width height:(CGFloat)height;

- (void)pushCellWithAnimation:(BOOL)animated;
- (void)pushCellWithAnimation:(BOOL)animated direction:(AMAnimatedTableCellDirections)direction;
- (void)pushCellWithAnimation:(BOOL)animated duration:(CGFloat)duration delay:(CGFloat)delay;
- (void)pushCellWithAnimation:(BOOL)animated duration:(CGFloat)duration delay:(CGFloat)delay direction:(AMAnimatedTableCellDirections)direction;
- (void)pushCellWithAnimation:(BOOL)animated duration:(CGFloat)duration delay:(CGFloat)delay offset:(CGFloat)offset direction:(AMAnimatedTableCellDirections)direction;

- (void)popCellWithAnimation:(BOOL)animated;
- (void)popCellWithAnimation:(BOOL)animated duration:(CGFloat)duration delay:(CGFloat)delay;
- (void)popCellWithAnimation:(BOOL)animated duration:(CGFloat)duration delay:(CGFloat)delay direction:(AMAnimatedTableCellDirections)direction;
- (void)popCellWithAnimation:(BOOL)animated duration:(CGFloat)duration delay:(CGFloat)delay offset:(CGFloat)offset direction:(AMAnimatedTableCellDirections)direction;

@end