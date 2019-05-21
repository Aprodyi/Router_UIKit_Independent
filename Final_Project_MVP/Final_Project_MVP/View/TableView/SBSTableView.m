//
//  TableView.m
//  Final_Project_MVP
//
//  Created by Вова on 08.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "SBSTableView.h"

@interface SBSTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *identifier;

//Activity Indicator
@property (nonatomic, strong) UIActivityIndicatorView *indicatorLoading;
@property (nonatomic, strong) UILabel *loadingLabel;

@end

@implementation SBSTableView

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
    
    [self.presenter clearTableView];
    self.identifier = nil;
    self.navigationItem.title = nil;
    [self.tableView reloadData];
    [self setLoadingScreen];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Table View Cell"];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Table View Cell"];
    if ([self.identifier isEqualToString: @"Colors"])
    {
        NSString *color = [self.presenter getPaletteColorAtSection:indexPath.section andRow:indexPath.row];
        NSString *percent = [self.presenter getPercentAtSection:indexPath.section andRow:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", color, percent];
        
        CGFloat red = [self.presenter getRedValueAtSection:indexPath.section andRow:indexPath.row];
        CGFloat green = [self.presenter getGreenValueAtSection:indexPath.section andRow:indexPath.row];
        CGFloat blue = [self.presenter getBlueValueAtSection:indexPath.section andRow:indexPath.row];
        cell.contentView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
        [cell.contentView.layer setBorderColor:[UIColor colorWithRed:red green:green blue:blue alpha:1.f].CGColor];
    }
    else
    {
        NSString *text = [self.presenter getClassicCellString:indexPath.row];
        cell.textLabel.text = text;
        cell.contentView.backgroundColor = [UIColor blackColor];
        [cell.contentView.layer setBorderColor:[UIColor blackColor].CGColor];
    }
    cell.textLabel.textColor = [UIColor brownColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.layer setCornerRadius:15.0f];
    cell.opaque = NO;
    [cell.layer setMasksToBounds:YES];
    [cell.contentView.layer setBorderWidth:2.0f];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.identifier isEqualToString: @"Colors"])
    {
        NSString *html = [self.presenter getHtmlStringAtSection:indexPath.section andRow:indexPath.row];
        NSString *parentColor = [self.presenter getParentColorAtSection:indexPath.section andRow:indexPath.row];
        NSString *htmlParentColor = [self.presenter getHtmlParentColorAtSection:indexPath.section andRow:indexPath.row];
   
        NSString *string = [NSString stringWithFormat:@"HTML код - %@\n Родительский цвет - %@\n HTML код родительского цвета - %@", html, parentColor, htmlParentColor];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Подробное описание" message:string preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"Понятно" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        [alert addAction:actionOK];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.identifier isEqualToString: @"Colors"])
    {
        CGRect frame = cell.frame;
        [cell setFrame:CGRectMake(0, self.tableView.frame.size.height, frame.size.width, frame.size.height)];
        [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionLayoutSubviews  animations:^{
            [cell setFrame:frame];
        } completion:^(BOOL finished) {
        }];
    }
    else
    {
        cell.transform = CGAffineTransformMakeTranslation(self.tableView.bounds.size.width, 0);
        [UIView animateWithDuration:0.5 delay:0.05*indexPath.row options:UIViewAnimationOptionCurveLinear  animations:^{
            cell.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
        }];
    }
}

#pragma mark - Protocol Methods

- (void)reloadTableViewWithIdentifier:(NSString *)identifier
{
    self.identifier = identifier;
    if ([self.identifier isEqualToString:@"Tags"])
    {
        self.navigationItem.title = @"Тэги изображения";
    }
    if ([self.identifier isEqualToString:@"Categories"])
    {
        self.navigationItem.title = @"Классификация изображения";
    }
    if ([self.identifier isEqualToString:@"Colors"])
    {
        self.navigationItem.title = @"Цвета изображения";
    }
    [self.indicatorLoading stopAnimating];
    [self.loadingLabel setHidden:YES];
    [self.tableView reloadData];
}

#pragma mark - Table View Section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = @"";
    if ([self.identifier isEqualToString:@"Colors"])
    {
        switch (section)
        {
            case 0:
                sectionName = @"Background colors";
                break;
            case 1:
                sectionName = @"Foreground colors";
                break;
            case 2:
                sectionName = @"Image colors";
                break;
            default:
                sectionName = @"";
                break;
        }
    }
    if ([self.identifier isEqualToString:@"Tags"])
    {
        sectionName = @"Тэг - Точность";
    }
    if ([self.identifier isEqualToString:@"Categories"])
    {
        sectionName = @"Категория - Точность";
    }
    
    return sectionName;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.identifier isEqualToString:@"Colors"])
    {
        return 3;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.identifier isEqualToString:@"Colors"])
    {
        return [self.presenter getRowsInSectionCount:section];
    }
    return [self.presenter getRows];
}

- (void)setLoadingScreen
{
    self.loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4 - 20, [UIScreen mainScreen].bounds.size.height/2 + 25, 150, 30)];
    self.loadingLabel.textColor = [UIColor blackColor];
    self.loadingLabel.textAlignment = NSTextAlignmentCenter;
    self.loadingLabel.center = self.view.center;
    self.loadingLabel.text = @"Загрузка данных";
    
    self.indicatorLoading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicatorLoading.color = [UIColor blackColor];
    self.indicatorLoading.hidesWhenStopped = YES;
    self.indicatorLoading.frame = CGRectMake(100, 150, 100, 100);
    self.indicatorLoading.center = CGPointMake(self.view.center.x, self.view.center.y - 15.f);
    
    [self.tableView addSubview:self.indicatorLoading];
    [self.tableView addSubview:self.loadingLabel];
    
    [self.indicatorLoading startAnimating];
}

@end
