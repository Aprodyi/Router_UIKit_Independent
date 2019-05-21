//
//  NetworkRequest.h
//  Final_Project_MVP
//
//  Created by Вова on 10.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBSNetworkRequestProtocol.h"
#import "SBSDataModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBSNetworkRequest : NSObject <SBSNetworkRequestProtocol>

@property (nonatomic, strong) id<SBSDataModelProtocol> model;

@end

NS_ASSUME_NONNULL_END
