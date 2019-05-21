//
//  PresenterProtocol.h
//  Final_Project_MVP
//
//  Created by Вова on 09.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

@protocol SBSPresenterProtocol <NSObject>

@required

//StartScreen
- (void)createImageScreenButtonWasPressed;
- (void)createDetectorScreen;

//ImagePhotoScreen
- (void)selectImageButtonWasPressed;
- (void)takePhotoButtonWasPressed;
- (void)nextButtonWasPressed;
- (void)imageCoreDataButtonWasPressed;
- (void)imagePickIsDoneWithData:(NSData *)imageData;

//MenuScreen
- (NSInteger)getArrayCount;
- (NSString *)getTextAtIndex:(NSInteger)index;
- (void)labelWasPressed:(NSString *)label;

//CropImageScreen
- (void)loadingCropIsDoneWithDataRecieved:(NSDictionary *)responseDict;
- (NSData *)getImageData;
- (void)cropButtonWasPressed;
- (void)saveImageToCoreData:(NSData *)imageData;

//TableViewScreen
- (void)uploadTableViewWithTagsDict:(NSDictionary *)responseDict;
- (void)uploadTableViewWithCategoriesDict:(NSDictionary *)responseDict;
- (void)uploadTableViewWithColorsDict:(NSDictionary *)responseDict;
- (NSString *)getHtmlStringAtSection:(NSUInteger)section andRow:(NSUInteger)row;
- (NSString *)getParentColorAtSection:(NSUInteger)section andRow:(NSUInteger)row;
- (NSString *)getHtmlParentColorAtSection:(NSUInteger)section andRow:(NSUInteger)row;
- (NSString *)getPaletteColorAtSection:(NSUInteger)section andRow:(NSUInteger)row;
- (NSString *)getPercentAtSection:(NSUInteger)section andRow:(NSUInteger)row;
- (float)getRedValueAtSection:(NSUInteger)section andRow:(NSUInteger)row;
- (float)getGreenValueAtSection:(NSUInteger)section andRow:(NSUInteger)row;
- (float)getBlueValueAtSection:(NSUInteger)section andRow:(NSUInteger)row;
- (NSString *)getClassicCellString:(NSUInteger)row;
- (NSUInteger)getRowsInSectionCount:(NSUInteger)section;
- (NSUInteger)getRows;
- (void)clearTableView;

//CollectionViewCoreData
- (NSUInteger)getCount;
- (NSData *)getImageAtIndex:(NSUInteger)index;
- (void)cellAtIndexWasPressed:(NSUInteger)index;

- (NSData *)getFullScreenImage;
- (void)backButtonWasPressed;

@end
