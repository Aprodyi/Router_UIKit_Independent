//
//  Images+CoreDataProperties.h
//  Final_Project_MVP
//
//  Created by Вова on 07.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//
//

#import "Images+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface Images (CoreDataProperties)

+ (NSFetchRequest<Images *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *image;

@end

NS_ASSUME_NONNULL_END
