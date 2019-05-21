//
//  Presenter.h
//  Final_Project_MVP
//
//  Created by Вова on 09.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Images+CoreDataClass.h"

#import "SBSRouterProtocol.h"

#import "SBSPresenterProtocol.h"
#import "SBSDataModelProtocol.h"

#import "SBSImagePhotoViewProtocol.h"
#import "SBSCollectionViewProtocol.h"
#import "SBSTableViewProtocol.h"
#import "SBSCropImageViewProtocol.h"
#import "SBSPickerViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBSPresenter : NSObject <SBSPresenterProtocol>

@property (nonatomic, strong) id<SBSRouterProtocol> router;

@property (nonatomic, weak) id<SBSDataModelProtocol> model;

@property (nonatomic, strong) id passiveViewStartScreen;
@property (nonatomic, strong) id<SBSImagePhotoViewProtocol> passiveViewImagePhoto;
@property (nonatomic, strong) id passiveViewMenu;
@property (nonatomic, strong) id<SBSCollectionViewProtocol> passiveViewCollection;
@property (nonatomic, strong) id<SBSTableViewProtocol> passiveViewTable;
@property (nonatomic, strong) id<SBSCropImageViewProtocol> passiveViewCropImage;
@property (nonatomic, strong) id passiveViewFullImage;
@property (nonatomic, strong) id<SBSPickerViewProtocol> passiveViewPicker;
@property (nonatomic, strong) id passiveViewGoogleDetect;

@property (nonatomic, copy) NSData *imageCoreData;
@property (nonatomic, copy, nullable) NSArray *responseArray;
@property (nonatomic, copy) NSArray <Images *> *coreDataImagesArray;

@end

NS_ASSUME_NONNULL_END
