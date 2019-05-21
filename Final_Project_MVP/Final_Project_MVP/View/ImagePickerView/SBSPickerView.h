//
//  PickerView.h
//  Final_Project_MVP
//
//  Created by Вова on 10.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBSPickerViewProtocol.h"
#import "SBSPresenterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBSPickerView : UIViewController <SBSPickerViewProtocol>

- (instancetype)initWithPresenter:(id<SBSPresenterProtocol>) presenter;
@property (nonatomic, weak) id<SBSPresenterProtocol> presenter;

@end

NS_ASSUME_NONNULL_END
