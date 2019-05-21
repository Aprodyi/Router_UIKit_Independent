//
//  Router.m
//  Final_Project_MVP
//
//  Created by Вова on 09.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "SBSRouter.h"
#import "TransitionAnimation.h"

@interface SBSRouter()

@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation SBSRouter

- (UINavigationController *)createNavigatioControllerWithRootViewController:(UIViewController *)rootViewController
{
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    self.navigationController.delegate = self;
    return self.navigationController;
}

- (void)pushViewController:(id)viewController
{
    [self.navigationController.view.layer addAnimation:[TransitionAnimation transitionAnimationWithType:kCATransitionPush andSubtype:kCATransitionFromBottom andDuration:1.0] forKey:kCATransition];
    [self.navigationController pushViewController:(UIViewController *)viewController animated:NO];
}

- (void)popViewController
{
    [self.navigationController.view.layer addAnimation:[TransitionAnimation transitionAnimationWithType:kCATransitionPush andSubtype:kCATransitionFromTop andDuration:1.0] forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
}

@end
