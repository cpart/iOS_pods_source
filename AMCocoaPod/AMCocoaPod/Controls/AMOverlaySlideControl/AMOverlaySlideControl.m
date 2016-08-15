//
//  AMOverlaySlideControl.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 08/09/14.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import "AMOverlaySlideControl.h"
#import "UIView+AMAdditions.h"

@interface AMOverlaySlideControl ()

@property (nonatomic) CGPoint offset;
@property (nonatomic) CGPoint touchesViewOffset;

- (void)initialize;
- (void)refreshAnimated:(BOOL)animated;
- (void)toggleState;
- (void)stateChanged;

@end

@implementation AMOverlaySlideControl

- (id) init {
    return [self initWithFrame:self.superview.frame];
}

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame topView:nil bottomView:nil touchesView:nil touchesViewOffset:CGPointMake(0.0f, 0.0f) openedOffset:CGPointMake(frame.origin.x, frame.origin.y) closedOffset:CGPointMake(frame.size.width, frame.size.height) open:YES animated:YES];
}

- (id)initWithFrame:(CGRect)frame topView:(UIView*)topView bottomView:(UIView*)bottomView touchesView:(UIView*)touchesView touchesViewOffset:(CGPoint)touchesViewOffset openedOffset:(CGPoint)openedOffset closedOffset:(CGPoint)closeOffset open:(BOOL)open animated:(BOOL)animated {
    self = [super initWithFrame:frame];
    
    if (self) {
        _topView = topView?topView:[[UIView alloc] init];
        _bottomView = bottomView?bottomView:[[UIView alloc] init];
        _openedOffset = openedOffset;
        _closeOffset = closeOffset;
        _open = open;
        _animated = animated;
        _touchesViewOffset = touchesViewOffset;
        
        _touchesView = touchesView?touchesView:[[UIView alloc] init];
        
        [self initialize];
    }
    
    return self;
}

- (void)initialize {
    [self addSubview:self.bottomView];
    [self addSubview:self.topView];
    [self addSubview:self.touchesView];
    
    [self refreshAnimated:NO];
    
    [self addObserver:self forKeyPath:kOpenKeyPath options:NSKeyValueObservingOptionNew context:nil];
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.touchesView addGestureRecognizer:singleFingerTap];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    if (recognizer.view == self.touchesView) {
        [self toggleState];
    }
}

- (void)refreshAnimated:(BOOL)animated {
    void (^refreshBlock)(void) = ^{
        CGRect topViewFrame = self.topView.frame;
        CGRect touchesViewFrame = self.touchesView.frame;
        
        if (self.isOpen) {
            topViewFrame.origin.y = self.openedOffset.y - self.touchesViewOffset.y;
            
            touchesViewFrame.origin.y = topViewFrame.origin.y + topViewFrame.size.height - touchesViewFrame.size.height + self.touchesViewOffset.y;
        } else {
            topViewFrame.origin.y = self.closeOffset.y - self.touchesViewOffset.y;
            
            touchesViewFrame.origin.y = topViewFrame.origin.y + topViewFrame.size.height - touchesViewFrame.size.height + self.touchesViewOffset.y;
        }
        
        self.topView.frame = topViewFrame;
        self.touchesView.frame = touchesViewFrame;
    };
    
    if (animated) {
        [UIView animateWithDuration:0.5f animations:refreshBlock];
    } else {
        refreshBlock();
    }
}

- (void)toggleState {
    self.open = !self.open;
}

- (void)stateChanged {
    [self refreshAnimated:self.animated];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kOpenKeyPath]) {
        [self stateChanged];
    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(isFinished))]) {
        if ([object isFinished]) {
            @try {
                [object removeObserver:self forKeyPath:NSStringFromSelector(@selector(isFinished))];
            }
            @catch (NSException * __unused exception) {}
        }
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:kOpenKeyPath];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
