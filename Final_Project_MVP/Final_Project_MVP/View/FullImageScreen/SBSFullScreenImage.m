//
//  FullScreenImage.m
//  Final_Project_MVP
//
//  Created by Вова on 07.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "SBSFullScreenImage.h"

@interface SBSFullScreenImage ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation SBSFullScreenImage

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
    
    self.navigationItem.title = @"Увеличенный обрезок";
    self.imageView = [[UIImageView alloc] initWithFrame: self.view.frame];
    self.imageView.backgroundColor = [UIColor blackColor];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview: self.imageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.imageView.image = [UIImage imageWithData:[self.presenter getFullScreenImage]];
}

@end
