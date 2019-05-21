//
//  ColorsDictionary.h
//  Final_Project_MVP
//
//  Created by Вова on 15.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

@import Foundation;

@interface ColorsDictionary : NSObject

+ (NSDictionary*)getConstDictionary;
+ (NSArray *)getBackgroundColorsArray;
+ (NSArray *)getForegroundColorsArray;
+ (NSArray *)getImageColorsArray;

@end
