//
//  StartScreenViewViewController.m
//  Final_project
//
//  Created by Вова on 06.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "SBSStartScreenView.h"
#import "TransitionAnimation.h"
#import "SBSImagePhotoViewProtocol.h"

@interface SBSStartScreenView ()

@end

@implementation SBSStartScreenView

- (instancetype)initWithPresenter:(id<SBSPresenterProtocol>) presenter
{
    if (self = [super init])
    {
        _presenter = presenter;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Финальное Приложение";
    CGFloat topBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height +
    self.navigationController.navigationBar.frame.size.height;
    
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageButton.frame = CGRectMake(10, topBarHeight + 10, CGRectGetWidth(self.view.frame) - 20, (CGRectGetHeight(self.view.frame) - topBarHeight)/2 - 10);
    [imageButton setTitle:@"Изображения" forState:UIControlStateNormal];
    [imageButton setBackgroundColor:[UIColor brownColor]];
    imageButton.layer.cornerRadius = 20.f;
    imageButton.layer.borderWidth = 5.f;
    imageButton.titleLabel.font = [UIFont systemFontOfSize: 45];
    imageButton.showsTouchWhenHighlighted = YES;
    imageButton.layer.borderColor = [UIColor blackColor].CGColor;
    [imageButton addTarget:self.presenter action:@selector(createImageScreenButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imageButton];
    
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraButton.frame = CGRectMake(10, (CGRectGetHeight(self.view.frame) + topBarHeight)/2 + 10, CGRectGetWidth(self.view.frame) - 20, (CGRectGetHeight(self.view.frame) - topBarHeight)/2 - 20);
    [cameraButton setTitle:@"Детектор лиц,\n текста\n и QR-кодов" forState:UIControlStateNormal];
    [cameraButton setBackgroundColor:[UIColor brownColor]];
    cameraButton.layer.cornerRadius = 20.f;
    cameraButton.layer.borderWidth = 5.f;
    cameraButton.titleLabel.font = [UIFont systemFontOfSize: 45];
    cameraButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cameraButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    cameraButton.showsTouchWhenHighlighted = YES;
    cameraButton.layer.borderColor = [UIColor blackColor].CGColor;
    [cameraButton addTarget:self action:@selector(buttonCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraButton];
}

- (void)buttonCamera
{
    [self.presenter createDetectorScreen];
}

@end
