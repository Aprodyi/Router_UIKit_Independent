//
//  PhotoProcessingViewController.h
//  Final_project
//
//  Created by Вова on 21.04.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBSPresenterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBSMenuView : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithPresenter:(id<SBSPresenterProtocol>) presenter;
@property (nonatomic, weak) id<SBSPresenterProtocol> presenter;

@end

NS_ASSUME_NONNULL_END
