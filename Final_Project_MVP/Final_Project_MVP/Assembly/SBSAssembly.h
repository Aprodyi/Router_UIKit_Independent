//
//  Assembly.h
//  Final_Project_MVP
//
//  Created by Вова on 07.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SBSDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBSAssembly : NSObject

+ (UINavigationController *)createDependency;
+ (SBSDataModel *)getDataModel;

@end

NS_ASSUME_NONNULL_END
