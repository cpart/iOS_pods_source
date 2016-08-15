//
//  CustomSegmentedControl.m
//  MyDay
//
//  Created by Raúl Pérez on 18/08/14.
//  Copyright (c) 2014 Adapt Mobile. All rights reserved.
//

#import "AMSegmentedControl.h"

@interface AMSegmentedControl ()

- (void)initialize;
- (void)refresh;

@end

@implementation AMSegmentedControl

- (id)initWithItems:(NSArray *)items {
    self = [super initWithItems:items];
    if (self) {
        // Initialization code
        _titleFont = [UIFont fontWithName:@"Arial" size:12];
        _titleColor = [UIColor whiteColor];
        _titleShadow = [[NSShadow alloc] init];
        self.backgroundColor = [UIColor clearColor];
        _backgroundImageStateNormal = [[UIImage alloc] init];
        _backgroundImageStateSelected = [[UIImage alloc] init];
        _separatorImage = [[UIImage alloc] init];
        
        [self initialize];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        _titleFont = [UIFont fontWithName:@"Arial" size:12];
        _titleColor = [UIColor whiteColor];
        _titleShadow = [[NSShadow alloc] init];
        self.backgroundColor = [UIColor clearColor];
        _backgroundImageStateNormal = [[UIImage alloc] init];
        _backgroundImageStateSelected = [[UIImage alloc] init];
        _separatorImage = [[UIImage alloc] init];
    }

    return self;
}

- (void)awakeFromNib {
    // Height
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.superview.frame.size.width, self.superview.frame.size.height)];

    [self initialize];
}

- (void)initialize {
    // Style the table

    // Handle selected segment changes by displaying the bottom arrow on the selected segment
    [self addTarget:self action:@selector(selectedSegmentChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self refresh];
}

- (void)refresh {
    // Background
    [self setBackgroundImage:self.backgroundImageStateNormal forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:self.backgroundImageStateSelected forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    // Separator
    [self setDividerImage:self.separatorImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setDividerImage:self.separatorImage forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setDividerImage:self.separatorImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    // Font
    NSMutableDictionary *attributes = [@{NSForegroundColorAttributeName: self.titleColor,
                                         NSFontAttributeName: self.titleFont,
                                         NSShadowAttributeName: self.titleShadow,
                                         }mutableCopy];
    
    NSDictionary *existingAttribtuesNormal = [self titleTextAttributesForState:UIControlStateNormal];
    
    for (NSString *key in existingAttribtuesNormal) {
        if (![attributes.allKeys containsObject:key]) {
            id attr = [existingAttribtuesNormal valueForKey:key];
            [attributes setValue:attr forKey:key];
        }
    }
    
    [self setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self setTitleTextAttributes:attributes forState:UIControlStateSelected];
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
    [super setSelectedSegmentIndex:selectedSegmentIndex];
    
    // Add the arrow to the selected segment
    [self selectedSegmentChanged:nil];
}

- (void)selectedSegmentChanged:(id)sender {
    if (sender) {
        //NSLog(@"selectedSegmentChanged");
    }
}

- (void)dealloc {
    [self removeTarget:self action:@selector(selectedSegmentChanged:) forControlEvents:UIControlEventValueChanged];
}

@end
