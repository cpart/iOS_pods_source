//
//  UIScrollView+AMAddition.h
//  Pods
//
//  Created by Raúl Pérez on 28/10/14.
//
//

#import <UIKit/UIKit.h>

@interface UIScrollView (AMAdditions)

- (void)addPaginatedViews:(NSArray*)paginatedViews;
- (void)addContentViews:(NSArray*)contentViews;

@end
