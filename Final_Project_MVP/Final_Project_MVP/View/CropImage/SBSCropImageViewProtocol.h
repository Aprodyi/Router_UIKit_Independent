//
//  CropImageViewProtocol.h
//  Final_Project_MVP
//
//  Created by Вова on 07.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

@protocol SBSCropImageViewProtocol <NSObject>

@required
- (void)cropRectWithX:(float)x1 andY:(float)y1 andHeight:(float)height andWidth:(float)width;
- (void)cutImage;

@end
