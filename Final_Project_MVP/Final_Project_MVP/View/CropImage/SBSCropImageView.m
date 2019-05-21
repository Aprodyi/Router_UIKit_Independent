//
//  ResponseImage.m
//  Final_project
//
//  Created by Вова on 24.04.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "SBSCropImageView.h"
#import "CroppingHelper.h"

@interface SBSCropImageView ()

@property (nonatomic, strong) UIImageView *inputImageView;
@property (nonatomic, strong) UIView *rectView;

//Activity Indicator
@property (nonatomic, strong) UIActivityIndicatorView *indicatorLoading;
@property (nonatomic, strong) UILabel *loadingLabel;

@end

@implementation SBSCropImageView

CGRect cropRect;

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
    newBackButton.tintColor = UIColor.blackColor;
    self.navigationItem.leftBarButtonItem = newBackButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.inputImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.inputImageView.image = [UIImage imageWithData:[self.presenter getImageData]];
    self.inputImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.inputImageView.layer.masksToBounds = YES;
    [self.view addSubview:self.inputImageView];
    
    [self setLoadingScreen];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    self.inputImageView.image = nil;
}

- (void)addCropRectOnScreen
{
    [self.indicatorLoading stopAnimating];
    [self.loadingLabel setHidden:YES];
    
//    CGRect imageCoordinates = [CroppingHelper frameForImage:self.inputImageView.image inImageViewAspectFit:self.inputImageView];
//    CGRect imageRect = cropRect;
//
//    const CGFloat imageViewScale = MAX(self.inputImageView.image.size.width /self.inputImageView.frame.size.width, self.inputImageView.image.size.height /self.inputImageView.frame.size.height);
//
//    imageRect.origin.x /= imageViewScale;
//    imageRect.origin.y /= imageViewScale;
//    imageRect.size.width /= imageViewScale;
//    imageRect.size.height /= imageViewScale;
//    
//    imageRect.origin.y += imageCoordinates.origin.y;
    CGRect scaleViewRect = [CroppingHelper getScaleRectWithImageView:self.inputImageView andCropRect:cropRect];
    self.rectView = [[UIView alloc] initWithFrame:scaleViewRect];
    [self.rectView setAlpha:0.5];
    self.rectView.backgroundColor = [UIColor greenColor];
    self.rectView.layer.cornerRadius = 10.f;
    self.rectView.layer.masksToBounds = YES;
    [self.inputImageView addSubview: self.rectView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Обрезать" style:UIBarButtonItemStylePlain target:self.presenter action:@selector(cropButtonWasPressed)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
}

- (void)cutImage
{
    [self.rectView removeFromSuperview];
    self.navigationItem.rightBarButtonItem = nil;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.inputImageView.image.CGImage, cropRect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    self.inputImageView.image = cropped;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Сохранить" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonWasPressed)];
    self.navigationItem.rightBarButtonItem.tintColor = UIColor.blackColor;
}

- (void)setLoadingScreen
{
    self.loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4 - 20, [UIScreen mainScreen].bounds.size.height/2 + 25, 150, 30)];
    self.loadingLabel.textColor = [UIColor yellowColor];
    self.loadingLabel.textAlignment = NSTextAlignmentCenter;
    self.loadingLabel.center = self.view.center;
    self.loadingLabel.text = @"Загрузка данных";
    
    self.indicatorLoading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicatorLoading.color = [UIColor yellowColor];
    self.indicatorLoading.hidesWhenStopped = YES;
    self.indicatorLoading.frame = CGRectMake(100, 150, 100, 100);
    self.indicatorLoading.center = CGPointMake(self.view.center.x, self.view.center.y - 15.f);
    
    [self.view addSubview:self.indicatorLoading];
    [self.view addSubview:self.loadingLabel];
    
    [self.indicatorLoading startAnimating];
}

#pragma mark - Core Data Save

- (void)saveButtonWasPressed
{
    [self.presenter saveImageToCoreData:UIImagePNGRepresentation(self.inputImageView.image)];
    self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark - Protocol Methods

- (void)cropRectWithX:(float)x1 andY:(float)y1 andHeight:(float)height andWidth:(float)width
{
    cropRect = CGRectMake(x1, y1, width, height);
    [self addCropRectOnScreen];
}

@end
