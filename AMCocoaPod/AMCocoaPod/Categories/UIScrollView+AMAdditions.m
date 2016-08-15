//
//  UIScrollView+AMAddition.m
//  Pods
//
//  Created by Raúl Pérez on 28/10/14.
//
//

#import "UIScrollView+AMAdditions.h"

@implementation UIScrollView (AMAdditions)

- (void)addPaginatedViews:(NSArray*)paginatedViews {
    self.autoresizesSubviews = NO;
    
    if (paginatedViews.count == 0) {
        return;
    }
    
    for (UIView *currentPageView in paginatedViews) {
        [currentPageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:currentPageView];
    }
    
    for (NSInteger i = 0; i < paginatedViews.count; i++) {
        UIView *currentPageView = paginatedViews[i];
        UIView *previousView = nil;
        UIView *nextView = nil;
        
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:currentPageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:currentPageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f];
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:currentPageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f];
        
        if (i == 0) {
            
            NSLayoutConstraint *firstPageLeadingConstraint = [NSLayoutConstraint constraintWithItem:currentPageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0];
            
            if (paginatedViews.count == 1) {
                NSLayoutConstraint *firstPageTrailingConstraint = [NSLayoutConstraint constraintWithItem:currentPageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
                [self addConstraint:firstPageTrailingConstraint];
            }
            
            [self addConstraint:firstPageLeadingConstraint];
        } else if (i == paginatedViews.count - 1) {
            previousView = paginatedViews[i - 1];
            
            NSLayoutConstraint *lastPageLeadingConstraint = [NSLayoutConstraint constraintWithItem:currentPageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:previousView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
            NSLayoutConstraint *lastPageTrailingConstraint = [NSLayoutConstraint constraintWithItem:currentPageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
            
            [self addConstraint:lastPageLeadingConstraint];
            [self addConstraint:lastPageTrailingConstraint];
        } else {
            previousView = paginatedViews[i - 1];
            nextView = paginatedViews[i + 1];
            
            NSLayoutConstraint *intermediatePageLeadingConstraint = [NSLayoutConstraint constraintWithItem:currentPageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:previousView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
            NSLayoutConstraint *intermediatePageTrailingConstraint = [NSLayoutConstraint constraintWithItem:currentPageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:nextView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0];
            
            [self addConstraint:intermediatePageLeadingConstraint];
            [self addConstraint:intermediatePageTrailingConstraint];
        }

        [self addConstraint:topConstraint];
        [self addConstraint:widthConstraint];
        [self addConstraint:heightConstraint];
    }
}

- (void)addContentViews:(NSArray*)contentViews {
    self.autoresizesSubviews = NO;
    
    if (contentViews.count == 0) {
        return;
    }
    
    for (UIView *currentContentView in contentViews) {
        [currentContentView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:currentContentView];
    }
    
    for (NSInteger i = 0; i < contentViews.count; i++) {
        UIView *currentContentView = contentViews[i];
        UIView *previousView = nil;
        UIView *nextView = nil;
        
        CGRect currentViewFrame = currentContentView.frame;
        
        NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:currentContentView attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f];
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0f constant:currentViewFrame.size.height];
        
        if (i == 0) {
            
            NSLayoutConstraint *firstPageLeadingConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0];
            
            if (contentViews.count == 1) {
                NSLayoutConstraint *firstPageTrailingConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
                [self addConstraint:firstPageTrailingConstraint];
            }
            
            [self addConstraint:firstPageLeadingConstraint];
        } else if (i == contentViews.count - 1) {
            previousView = contentViews[i - 1];
            
            NSLayoutConstraint *lastPageLeadingConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:previousView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
            NSLayoutConstraint *lastPageTrailingConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
            
            [self addConstraint:lastPageLeadingConstraint];
            [self addConstraint:lastPageTrailingConstraint];
        } else {
            previousView = contentViews[i - 1];
            nextView = contentViews[i + 1];
            
            NSLayoutConstraint *intermediatePageLeadingConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:previousView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
            NSLayoutConstraint *intermediatePageTrailingConstraint = [NSLayoutConstraint constraintWithItem:currentContentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:nextView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0];
            
            [self addConstraint:intermediatePageLeadingConstraint];
            [self addConstraint:intermediatePageTrailingConstraint];
        }
        
        [self addConstraint:centerYConstraint];
        [self addConstraint:widthConstraint];
        [self addConstraint:heightConstraint];
    }
}

@end
