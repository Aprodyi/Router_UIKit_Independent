//
//  Assembly.m
//  Final_Project_MVP
//
//  Created by Вова on 07.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "SBSAssembly.h"
#import "SBSPresenter.h"

#import "SBSRouter.h"
#import "SBSNetworkRequest.h"

#import "SBSStartScreenView.h"
#import "SBSImagePhotoView.h"
#import "SBSMenuView.h"
#import "SBSCropImageView.h"
#import "SBSCollectionView.h"
#import "SBSTableView.h"
#import "SBSFullScreenImage.h"
#import "SBSPickerView.h"
#import "SBSGoogleDetectView.h"

SBSDataModel *dataModel;

@implementation SBSAssembly

+ (UINavigationController *)createDependency
{
    SBSRouter *router = [SBSRouter new];
    
    SBSPresenter *presenter = [SBSPresenter new];
    presenter.router = router;

    dataModel = [[SBSDataModel alloc] initWithPresenter:presenter];
    
    SBSNetworkRequest *networkRequest = [SBSNetworkRequest new];
    dataModel.networkService = networkRequest;
    networkRequest.model = dataModel;
    
    SBSCollectionView *collectionView = [[SBSCollectionView alloc] initWithPresenter:presenter];
    SBSTableView *tableView = [[SBSTableView alloc] initWithPresenter:presenter];
    SBSCropImageView *cropImageView = [[SBSCropImageView alloc] initWithPresenter:presenter];
    SBSMenuView *menuView = [[SBSMenuView alloc] initWithPresenter:presenter];
    SBSImagePhotoView *imagePhotoView = [[SBSImagePhotoView alloc] initWithPresenter:presenter];
    SBSStartScreenView *startScreenView = [[SBSStartScreenView alloc] initWithPresenter:presenter];
    SBSFullScreenImage *fullScreenImage = [[SBSFullScreenImage alloc] initWithPresenter:presenter];
    SBSPickerView *pickerView = [[SBSPickerView alloc] initWithPresenter:presenter];
    SBSGoogleDetectView *googleDetectView = [[SBSGoogleDetectView alloc] initWithPresenter:presenter];
    
    presenter.model = dataModel;
    presenter.passiveViewStartScreen = startScreenView;
    presenter.passiveViewImagePhoto = imagePhotoView;
    presenter.passiveViewMenu = menuView;
    presenter.passiveViewCollection = collectionView;
    presenter.passiveViewTable = tableView;
    presenter.passiveViewCropImage = cropImageView;
    presenter.passiveViewFullImage = fullScreenImage;
    presenter.passiveViewPicker = pickerView;
    presenter.passiveViewGoogleDetect = googleDetectView;
    
    UINavigationController *navigationController = [router createNavigatioControllerWithRootViewController:startScreenView];
    
    return navigationController;
}

+ (SBSDataModel *)getDataModel
{
    return dataModel;
}

@end
