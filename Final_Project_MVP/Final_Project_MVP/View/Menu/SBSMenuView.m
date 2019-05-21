//
//  PhotoProcessingViewController.m
//  Final_project
//
//  Created by Вова on 21.04.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "SBSMenuView.h"

@interface SBSMenuView ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SBSMenuView

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

    self.navigationItem.title = @"Обработка";
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:self.presenter action:@selector(backButtonWasPressed)];
    newBackButton.tintColor = UIColor.blackColor;
    self.navigationItem.leftBarButtonItem = newBackButton;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    self.tableView.alwaysBounceVertical = YES;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Table View Cell"];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.presenter getArrayCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Table View Cell"];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Table View Cell"];
    cell.textLabel.text = [self.presenter getTextAtIndex:indexPath.row];
    cell.contentView.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.textColor = [UIColor blackColor];
    [cell.layer setCornerRadius:15.0f];
    [cell.layer setMasksToBounds:YES];
    [cell.contentView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [cell.contentView.layer setBorderWidth:0.3f];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.presenter labelWasPressed:cell.textLabel.text];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    cell.transform = CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height);
    [UIView animateWithDuration:2 delay:1*indexPath.row usingSpringWithDamping:0.4 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        cell.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
    }];
}

@end
