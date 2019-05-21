//
//  GoogleDetectView.m
//  Final_Project_MVP
//
//  Created by Вова on 14.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "SBSGoogleDetectView.h"

@interface SBSGoogleDetectView ()

@property (nonatomic, weak) id<SBSPresenterProtocol> presenter;

@end

@implementation SBSGoogleDetectView

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

    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:self.presenter action:@selector(backButtonWasPressed)];
    newBackButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = newBackButton;
    
    UITextView *textField = [[UITextView alloc] initWithFrame:self.view.frame];
    textField.font = [UIFont systemFontOfSize:20];
    textField.text = @"    Для работы этого дополнительного функционала, необходимо скачать проект с Яндекс Диска (ссылка в README). \n    Т.к. github не позволяет загружать файлы размером > 100Мб. А тут используется библиотека от Google (GoogleMobileVision). \n    Данная часть выполнена без архитектуры, т.к. это дополнительный функционал и не хватает времени переделать.";
    textField.textAlignment = NSTextAlignmentJustified;
    [self.view addSubview:textField];
}

@end
