//
//  AMCollectionViewDataSource.m
//  AMCocoaPod
//
//  Created by Raúl Pérez on 09/09/14.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import "AMCollectionViewDataSource.h"

static NSString* cellIdentifierId = @"Cell";

@interface AMCollectionViewDataSource ()

- (void)initialize;

@end

@implementation AMCollectionViewDataSource

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
    if (self.items == nil) {
        self.items = @[];
    }

    if (self.sections == nil) {
        self.sections = @[];
    }
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return (NSInteger)[self.items count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    return (NSInteger)[self.sections count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifierId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

+ (instancetype)dataSource {
    return [[[self class] alloc] init];
}

@end
