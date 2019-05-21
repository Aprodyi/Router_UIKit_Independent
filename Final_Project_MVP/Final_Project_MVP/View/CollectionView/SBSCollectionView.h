//
//  CollectionViewViewController.h
//  Final_Project_MVP
//
//  Created by Вова on 07.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBSPresenterProtocol.h"
#import "SBSCollectionViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBSCollectionView : UIViewController <SBSCollectionViewProtocol>

- (instancetype)initWithPresenter:(id<SBSPresenterProtocol>) presenter;
@property (nonatomic, weak) id<SBSPresenterProtocol> presenter;

@end

NS_ASSUME_NONNULL_END
