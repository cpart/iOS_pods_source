//
//  AMOverlaySlideControl.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 08/09/14.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kOpenKeyPath @"open"

@interface AMOverlaySlideControl : UIControl

@property (nonatomic) UIView *topView;
@property (nonatomic) UIView *bottomView;
@property (nonatomic) UIView *touchesView;
@property (nonatomic) CGPoint openedOffset;
@property (nonatomic) CGPoint closeOffset;
@property (nonatomic, getter = isOpen) BOOL open;
@property (nonatomic, getter = isAnimated) BOOL animated;

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame topView:(UIView*)topView bottomView:(UIView*)bottomView touchesView:(UIView*)touchesView touchesViewOffset:(CGPoint)touchesViewOffset openedOffset:(CGPoint)openedOffset closedOffset:(CGPoint)closeOffset open:(BOOL)open animated:(BOOL)animated;

- (void)toggleState;

@end
