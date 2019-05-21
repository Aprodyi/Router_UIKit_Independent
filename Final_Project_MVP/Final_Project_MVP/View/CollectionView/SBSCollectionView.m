//
//  CollectionViewViewController.m
//  Final_Project_MVP
//
//  Created by Вова on 07.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "SBSCollectionView.h"
#import "CollectionViewCell.h"
#import "SBSFullScreenImage.h"

@interface SBSCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SBSCollectionView

- (instancetype)initWithPresenter:(id<SBSPresenterProtocol>) presenter
{
    if (self = [super init])
    {
        _presenter = presenter;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:self.presenter action:@selector(backButtonWasPressed)];
    newBackButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = newBackButton;
    
    [self makeUI];
}

#pragma mark - UI

-(void)makeUI
{
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"Сохраненные обрезки";
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    [layout setMinimumInteritemSpacing:2];
    [layout setMinimumLineSpacing:2];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.dataSource = self;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"Cell Identifier"];
    [self.view addSubview:self.collectionView];
}

#pragma mark - Flow Layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width/2 - 2, collectionView.frame.size.width/2 - 2);
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.presenter cellAtIndexWasPressed:indexPath.row];
}

#pragma mark - Collection View Data Source

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell Identifier" forIndexPath:indexPath];
    
    NSData *imageCoreData = [self.presenter getImageAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageWithData:imageCoreData];
    cell.imageView.layer.cornerRadius = 10.0;
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.presenter getCount];
}

#pragma mark - Protocol Methods

- (void)reloadCollectionView
{
    [self.collectionView reloadData];
}

@end
