//
//  AMCollectionViewController.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 09/09/14.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMCollectionViewDataSource;
@class AMCollectionViewDelegate;

@interface AMCollectionViewController : UIViewController

@property (nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) AMCollectionViewDataSource *dataSource;
@property (nonatomic) AMCollectionViewDelegate *delegate;
@property (nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic) Class cellClass;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil cellClass:(Class)cellClass;
- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil dataSource:(AMCollectionViewDataSource*)dataSource delegate:(AMCollectionViewDelegate*)delegate flowLayout:(UICollectionViewFlowLayout*)flowLayout cellClass:(Class)cellClass;

@end
