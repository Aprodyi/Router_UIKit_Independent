//
//  MenuModel.m
//  Final_Project_MVP
//
//  Created by Вова on 07.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "SBSDataModel.h"
#import "Images+CoreDataClass.h"
#import "AppDelegate.h"

@interface SBSDataModel()

@property (nonatomic, strong) id<SBSPresenterProtocol> presenter;
@property (nonatomic, strong) NSArray *processingArray;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;

@end

@implementation SBSDataModel

- (instancetype)initWithPresenter:(id<SBSPresenterProtocol>) presenter
{
    if (self = [super init])
    {
        _processingArray = @[@"Тэги", @"Классификация", @"Интеллектуальная обрезка", @"Цвета"];
        _presenter = presenter;
    }
    return self;
}

#pragma mark - Array MenuView with cell name

- (NSArray *)getProcessingArray
{
    return _processingArray;
}

#pragma mark - UserDefaults

- (void)saveImageData:(NSData *)imageData
{
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"SelectImage"];
}

- (NSData *)getImageData
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectImage"];
}

#pragma mark - Nerwork Service

- (void)getTags
{
    [self.networkService networkRequestWithEndpoint:@"Tags"];
}

- (void)getCategories
{
    [self.networkService networkRequestWithEndpoint:@"Categories"];
}

- (void)getColors
{
    [self.networkService networkRequestWithEndpoint:@"Colors"];
}

- (void)getCropImage
{
    [self.networkService networkRequestWithEndpoint:@"Crop"];
}

#pragma mark - Network Protocol

- (void)loadingTagsIsDoneWithData:(NSDictionary *)responseDict
{
    [self.presenter uploadTableViewWithTagsDict:responseDict];
}

- (void)loadingCategoriesIsDoneWithData:(NSDictionary *)responseDict
{
    [self.presenter uploadTableViewWithCategoriesDict:responseDict];
}

- (void)loadingColorsIsDoneWithData:(NSDictionary *)responseDict
{
    [self.presenter uploadTableViewWithColorsDict:responseDict];
}

- (void)loadingCropImageIsDoneWithData:(NSDictionary *)responseDict
{
    [self.presenter loadingCropIsDoneWithDataRecieved:responseDict];
}

#pragma mark - Core Data

- (void)saveImageToCoreData:(NSData *)imageData
{
    Images *image = [NSEntityDescription insertNewObjectForEntityForName:@"Images" inManagedObjectContext: [self coreDataContext]];
    image.image = imageData;
    
    if (![image.managedObjectContext save:nil])
    {
        NSLog(@"Ошибка сохранения !");
    }
}

- (NSArray *)getPhotoArray
{
    NSArray *photoArray = [self.coreDataContext executeFetchRequest:self.fetchRequest ? : [Images fetchRequest] error:nil];
    return photoArray;
}

- (NSManagedObjectContext *)coreDataContext
{
    if (_coreDataContext)
    {
        return _coreDataContext;
    }
    
    NSPersistentContainer *container = [self persistentContainer];
    NSManagedObjectContext *context = container.viewContext;
    return context;
}

- (NSFetchRequest *)fetchRequest
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Images"];
    return fetchRequest;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer
{
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self)
    {
        if (_persistentContainer == nil)
        {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"DataModel"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil)
                {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext
{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    
    if ([context hasChanges] && ![context save:&error])
    {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
