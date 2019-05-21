//
//  CroppingImage.h
//  Final_Project_MVP
//
//  Created by Вова on 12.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CroppingHelper : NSObject

+ (CGRect)getScaleRectWithImageView:(UIImageView *)inputImageView andCropRect:(CGRect)cropRect;

@end

NS_ASSUME_NONNULL_END
