//
//  Images+CoreDataProperties.m
//  Final_Project_MVP
//
//  Created by Вова on 07.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//
//

#import "Images+CoreDataProperties.h"

@implementation Images (CoreDataProperties)

+ (NSFetchRequest<Images *> *)fetchRequest
{
	return [NSFetchRequest fetchRequestWithEntityName:@"Images"];
}

@dynamic image;

@end
