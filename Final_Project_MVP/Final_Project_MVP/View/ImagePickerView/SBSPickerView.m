//
//  PickerView.m
//  Final_Project_MVP
//
//  Created by Вова on 10.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "SBSPickerView.h"

@interface SBSPickerView () < UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation SBSPickerView

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
    // Do any additional setup after loading the view.
}

#pragma mark - Picker Controller

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIViewController *topViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [topViewController dismissViewControllerAnimated:picker completion:nil];
    
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    NSData *imageData = UIImagePNGRepresentation(image);
    [self.presenter imagePickIsDoneWithData:imageData];
}

#pragma mark - Protocol Methods

- (void)runGalleryPickerController
{
    UIImagePickerController *pickerViewController = [[UIImagePickerController alloc] init];
    pickerViewController.allowsEditing = YES;
    pickerViewController.delegate = self;
    [pickerViewController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];

    UIViewController *topViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [topViewController presentViewController:pickerViewController animated:YES completion:nil];
}

- (void)runCameraPickerController
{
    UIViewController *topViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *pickerViewController =[[UIImagePickerController alloc]init];
        pickerViewController.allowsEditing = YES;
        pickerViewController.delegate = self;
        pickerViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [topViewController presentViewController:pickerViewController animated:YES completion:nil];
    }
    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Ошибка" message:@"Камера недоступна" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [topViewController presentViewController:alert animated:YES completion:nil];
    }
}

@end
