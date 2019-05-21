//
//  CroppingImage.m
//  Final_Project_MVP
//
//  Created by Вова on 12.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "CroppingHelper.h"

@implementation CroppingHelper

/**
 Получить размер изображения, которое AspectFit

 @param image изображение
 @param imageView с размерами экрана
 @return прямоугольник с размерами изображения
 */
+ (CGRect)frameForImage:(UIImage*)image inImageViewAspectFit:(UIImageView*)imageView
{
    CGFloat imageRatio = image.size.width / image.size.height;
    CGFloat viewRatio = imageView.frame.size.width / imageView.frame.size.height;
    if(imageRatio < viewRatio)
    {
        CGFloat scale = imageView.frame.size.height / image.size.height;
        CGFloat width = scale * image.size.width;
        CGFloat topLeftX = (imageView.frame.size.width - width) * 0.5;
        
        return CGRectMake(topLeftX, 0, width, imageView.frame.size.height);
    }
    else
    {
        CGFloat scale = imageView.frame.size.width / image.size.width;
        CGFloat height = scale * image.size.height;
        CGFloat topLeftY = (imageView.frame.size.height - height) * 0.5;
        
        return CGRectMake(0, topLeftY, imageView.frame.size.width, height);
    }
}

/**
 Конвертируем прямоугольник из пиксилей изображения в поинты экрана

 @param inputImageView Image View с изображением
 @param cropRect прямоугольник в пикселях
 @return прямоугольник в поинтах
 */
+ (CGRect)getScaleRectWithImageView:(UIImageView *)inputImageView andCropRect:(CGRect)cropRect
{
    const CGFloat imageViewScale = MAX(inputImageView.image.size.width / inputImageView.frame.size.width, inputImageView.image.size.height / inputImageView.frame.size.height);
    CGRect imageCoordinates = [self frameForImage:inputImageView.image inImageViewAspectFit:inputImageView];
    cropRect.origin.x /= imageViewScale;
    cropRect.origin.y /= imageViewScale;
    cropRect.size.width /= imageViewScale;
    cropRect.size.height /= imageViewScale;
    cropRect.origin.y += imageCoordinates.origin.y;
    
    return cropRect;
}

@end
