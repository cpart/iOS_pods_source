//
//  AMCollectionViewDelegate.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 09/09/14.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import "AMCollectionViewDelegate.h"

@implementation AMCollectionViewDelegate

- (id)init {
    self = [super init];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (void)awakeFromNib {
    [self initialize];
}

- (void)initialize {
}

+ (instancetype)delegate {
    return [[[self class] alloc] init];
}

@end
