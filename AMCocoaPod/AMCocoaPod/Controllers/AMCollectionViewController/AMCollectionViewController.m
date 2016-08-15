//
//  AMCollectionViewController.m
//  LOAMCocoaPodPlus
//
//  Created by Raúl Pérez on 09/09/14.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import "AMCollectionViewController.h"
#import "AMCollectionViewDataSource.h"
#import "AMCollectionViewDelegate.h"

static NSString* cellIdentifierId = @"Cell";

@interface AMCollectionViewController ()

@end

@implementation AMCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil cellClass:nil];
}

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil cellClass:(Class)cellClass {
    return [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil dataSource:nil delegate:nil flowLayout:nil cellClass:cellClass];
}

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil dataSource:(AMCollectionViewDataSource*)dataSource delegate:(AMCollectionViewDelegate*)delegate flowLayout:(UICollectionViewFlowLayout*)flowLayout cellClass:(Class)cellClass {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.dataSource = dataSource?dataSource:[AMCollectionViewDataSource dataSource];
        self.delegate = delegate?delegate:[AMCollectionViewDelegate delegate];
        self.flowLayout = flowLayout?flowLayout:[UICollectionViewFlowLayout new];
        self.cellClass = cellClass?cellClass:[UICollectionViewCell class];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
    }
    
    return self;
}

- (void)awakeFromNib {
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.flowLayout = self.flowLayout?self.flowLayout:[UICollectionViewFlowLayout new];
    self.cellClass = self.cellClass?self.cellClass:[UICollectionViewCell class];

    self.collectionView.dataSource = self.dataSource;
    self.collectionView.delegate = self.delegate;
    self.collectionView.collectionViewLayout = self.flowLayout;

    [self.collectionView registerClass:self.cellClass forCellWithReuseIdentifier:@"Cell"];
}

- (void)setDataSource:(AMCollectionViewDataSource *)dataSource {
    _dataSource = dataSource;
    self.collectionView.dataSource = _dataSource;
    [self.collectionView reloadData];
}

- (void)setDelegate:(AMCollectionViewDelegate *)delegate {
    _delegate = delegate;
    self.collectionView.delegate = _delegate;
    [self.collectionView reloadData];
}

- (void)setFlowLayout:(UICollectionViewFlowLayout *)flowLayout {
    _flowLayout = flowLayout;
    self.collectionView.collectionViewLayout = _flowLayout;
    [self.collectionView reloadData];
}

- (void)setCellClass:(Class)cellClass {
    _cellClass = cellClass;
    [self.collectionView registerClass:self.cellClass forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
