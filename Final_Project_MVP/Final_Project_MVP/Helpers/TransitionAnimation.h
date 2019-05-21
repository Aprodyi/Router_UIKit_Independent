//
//  TransitionAnimation.h
//  Final_project
//
//  Created by Вова on 01.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface TransitionAnimation : NSObject

+ (CATransition *)transitionAnimationWithType: (CATransitionType)type andSubtype: (CATransitionSubtype)subtype andDuration: (CFTimeInterval)duration;

@end

NS_ASSUME_NONNULL_END
