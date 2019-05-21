//
//  GoogleDetectView.h
//  Final_Project_MVP
//
//  Created by Вова on 14.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBSPresenterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBSGoogleDetectView : UIViewController

- (instancetype)initWithPresenter:(id<SBSPresenterProtocol>) presenter;

@end

NS_ASSUME_NONNULL_END
