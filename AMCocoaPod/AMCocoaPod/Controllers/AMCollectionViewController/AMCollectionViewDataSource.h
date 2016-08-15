//
//  AMCollectionViewDataSource.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 09/09/14.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMCollectionViewDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *sections;

+ (instancetype)dataSource;

@end
