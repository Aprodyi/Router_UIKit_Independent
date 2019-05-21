//
//  Router.h
//  Final_Project_MVP
//
//  Created by Вова on 09.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "UIKit/UIKit.h"
#import <Foundation/Foundation.h>
#import "SBSRouterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBSRouter : NSObject <UINavigationControllerDelegate, SBSRouterProtocol>

- (UINavigationController *)createNavigatioControllerWithRootViewController:(UIViewController *)rootViewController;

@end

NS_ASSUME_NONNULL_END
