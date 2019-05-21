//
//  MenuModel.h
//  Final_Project_MVP
//
//  Created by Вова on 07.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SBSDataModelProtocol.h"
#import "SBSPresenterProtocol.h"
#import "SBSNetworkRequestProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBSDataModel : NSObject <SBSDataModelProtocol>

@property (nonatomic, strong) id<SBSNetworkRequestProtocol> networkService;
- (instancetype)initWithPresenter:(id<SBSPresenterProtocol>) presenter;

- (void)saveContext;

@end

NS_ASSUME_NONNULL_END
