//
//  Presenter.m
//  Final_Project_MVP
//
//  Created by Вова on 09.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "SBSPresenter.h"

@implementation SBSPresenter

#pragma mark - StartScreenViewProtocol

/**
 Router пушит экран с выбором изображения (ImagePhotoView)
 */
- (void)createImageScreenButtonWasPressed
{
    [self.router pushViewController: self.passiveViewImagePhoto];
}

/**
 Router пушит экран-заглушку вместо GoogleDetectView
 */
- (void)createDetectorScreen
{
    [self.router pushViewController:self.passiveViewGoogleDetect];
}

#pragma mark - ImagePhotoView

/**
 Запускем PickerController для выбора изображения из галерии
 */
- (void)selectImageButtonWasPressed
{
    [self.passiveViewPicker runGalleryPickerController];
}

/**
 Запускем PickerController для получения изображения с помощью камеры
 */
- (void)takePhotoButtonWasPressed
{
    [self.passiveViewPicker runCameraPickerController];
}

/**
 Метод выывается после выбора изображения с помощью PickerController-a
 Добавляем кнопку "Далее" на экран ImagePhotoView
 Сохраняем изображение в UserDefaults
 Добавляем изображение на экран ImagePhotoView

 @param imageData Изображение в формате NSData
 */
- (void)imagePickIsDoneWithData:(NSData *)imageData
{
    if (imageData != nil)
    {
        [self.passiveViewImagePhoto createNextButton];
        [self.model saveImageData:imageData];
        [self.passiveViewImagePhoto uploadImageData:imageData];
    }
}

/**
 Router пушит экран с меню выбора действия (MenuView) после нажатия кнопки "Далее"
 */
- (void)nextButtonWasPressed
{
    [self.router pushViewController:self.passiveViewMenu];
}

/**
 Нажата кнопка "Изображения Core Data" на экране ImagePhotoView
 Router пушит CollectionView с сохраненками
 Забираем из модели массив с изображениями
 Обновляем collection view
 */
- (void)imageCoreDataButtonWasPressed
{
    [self.router pushViewController:self.passiveViewCollection];
    NSArray *photoArray = [self.model getPhotoArray];
    self.coreDataImagesArray = photoArray;//.mutableCopy;
    [self.passiveViewCollection reloadCollectionView];
}

#pragma mark - MenuViewProtocol

/**
 Количство элементов в MenuView

 @return количество элементов меню
 */
- (NSInteger)getArrayCount
{
    return [self.model getProcessingArray].count;
}

/**
 Получить название элемента MenuView по индексу

 @param index индекс
 @return название строки меню
 */
- (NSString *)getTextAtIndex:(NSInteger)index
{
    if (index > [self getArrayCount] - 1)
    {
        return @"Выход за границы массива";
    }
    return [[self.model getProcessingArray] objectAtIndex:index];
}

/**
 Обработка нажатия определенной строки MenuView

 @param label строка с названием MenuView
 */
- (void)labelWasPressed:(NSString *)label
{
    NSInteger item = [[self.model getProcessingArray] indexOfObject:label];
    switch (item)
    {
        case 0:
        {
            [self.router pushViewController:self.passiveViewTable];
            [self.model getTags];
            break;
        }
            
        case 1:
        {
            [self.router pushViewController:self.passiveViewTable];
            [self.model getCategories];
            break;
        }
            
        case 2:
        {
            [self.router pushViewController:self.passiveViewCropImage];
            [self.model getCropImage];
            break;
        }
            
        case 3:
        {
            [self.router pushViewController:self.passiveViewTable];
            [self.model getColors];
            break;
        }
            
        default:
            break;
    }

}

#pragma mark - CropImageViewProtocol

/**
 Обработка словаря с координатами наилучшей обрезки

 @param responseDict словарь с координатми левого верхнего угла прямоугольника, его выосты и ширины
 */
- (void)loadingCropIsDoneWithDataRecieved:(NSDictionary *)responseDict
{
    if ([[responseDict valueForKeyPath:@"status.type"] isEqualToString:@"success"])
    {
        NSDictionary *mainRect = [responseDict valueForKeyPath:@"result.croppings"][0];
        float x1 = [[mainRect valueForKey:@"x1"] floatValue];
        float y1 = [[mainRect valueForKey:@"y1"] floatValue];
        float height = [[mainRect valueForKey:@"target_height"] floatValue];
        float width = [[mainRect valueForKey:@"target_width"] floatValue];
    
        [self.passiveViewCropImage cropRectWithX: x1 andY: y1 andHeight: height andWidth: width];
    }
}

/**
 Получить изображение, которое было выбрано на экране ImagePhoto, в формате NSData из UserDefaults

 @return изображение в формате NSData
 */
- (NSData *)getImageData
{
    return [self.model getImageData];
}

/**
 Нажата кнопка обрезки, при нажатии на нее изображение обрезается по координатам полученным с API
 */
- (void)cropButtonWasPressed
{
    [self.passiveViewCropImage cutImage];
}

/**
 Сохранить обрезанное изображение в CoreData

 @param imageData Изображение в формате NSData
 */
- (void)saveImageToCoreData:(NSData *)imageData
{
    [self.model saveImageToCoreData:imageData];
}

#pragma mark - TableViewProtocol

/**
 Обработка словаря с тэгами изображения и обновление TableView
 Сначала проверяем тип статуса ответа
 Затем формируем массив, со значениями вида:"Тэг - точность"
 Обновляем Table View

 @param responseDict словарь с тэгами и точностью
 */
- (void)uploadTableViewWithTagsDict:(NSDictionary *)responseDict
{
    NSMutableArray *responseTagsArray = [NSMutableArray new];
    if ([[responseDict valueForKeyPath:@"status.type"] isEqualToString:@"success"])
    {
        for (NSUInteger index=0; index < [[responseDict valueForKeyPath:@"result.tags.tag.ru"] count]; index++)
        {
            NSString *tag = [responseDict valueForKeyPath:@"result.tags.tag.ru"][index];
            NSString *confidence = [responseDict valueForKeyPath:@"result.tags.confidence"][index];
            [responseTagsArray addObject:[NSString stringWithFormat:@"%@ - %@", tag, confidence]];
        }
        NSArray *tagsData = responseTagsArray.copy;
        self.responseArray = [[NSArray alloc] initWithArray:tagsData];
    }
    else
    {
        self.responseArray = nil;
    }
    [self.passiveViewTable reloadTableViewWithIdentifier:@"Tags"];
}

/**
 Обработка словаря с категориями(классификацией) изображения и обновление TableView
 Сначала проверяем тип статуса ответа
 Затем формируем массив, со значениями вида:"Классификатор - точность"
 Обновляем Table View
 
 @param responseDict словарь с классификаторами и точностью
 */
- (void)uploadTableViewWithCategoriesDict:(NSDictionary *)responseDict
{
    NSMutableArray *responseCategoriesArray = [NSMutableArray new];
    if ([[responseDict valueForKeyPath:@"status.type"] isEqualToString:@"success"])
    {
        for (NSUInteger index=0; index < [[responseDict valueForKeyPath:@"result.categories.name.ru"] count]; index++)
        {
            NSString *categories = [responseDict valueForKeyPath:@"result.categories.name.ru"][index];
            NSString *confidence = [responseDict valueForKeyPath:@"result.categories.confidence"][index];
            [responseCategoriesArray addObject:[NSString stringWithFormat:@"%@ - %@", categories, confidence]];
        }
        NSArray *categoriesData = responseCategoriesArray.copy;
        self.responseArray = [[NSArray alloc] initWithArray:categoriesData];
    }
    else
    {
        self.responseArray = nil;
    }
    [self.passiveViewTable reloadTableViewWithIdentifier:@"Categories"];
}

/**
 Обработка словаря с цветами: переднего, заднего и самого изображения. Затем обновляется TableView
 Сначала проверяем тип статуса ответа
 Затем формируем 3 массива с цветами переднего, заднего плана и самого изображения
 Формируем общий массив из всех 3-ех
 Обновляем Table View

 @param responseDict словарь с цветами и дополнительной информацией
 */
- (void)uploadTableViewWithColorsDict:(NSDictionary *)responseDict
{
    if ([[responseDict valueForKeyPath:@"status.type"] isEqualToString:@"success"])
    {
        NSArray *backgroundColors = [responseDict valueForKeyPath:@"result.colors.background_colors"];
        NSArray *foregroundColors = [responseDict valueForKeyPath:@"result.colors.foreground_colors"];
        NSArray *imageColors = [responseDict valueForKeyPath:@"result.colors.image_colors"];
        NSArray *responseColorsArray = [NSArray arrayWithObjects: backgroundColors, foregroundColors, imageColors, nil];
        
        self.responseArray = [[NSArray alloc] initWithArray:responseColorsArray];
    }
    else
    {
        self.responseArray = nil;
    }
    [self.passiveViewTable reloadTableViewWithIdentifier:@"Colors"];
}

/**
 Получить HTML код цвета из массива цветов responseArray

 @param section 0 - задний план, 1 - передний план, 2 - изображение
 @param row номер цвета по порядку
 @return строка с HTML кодом
 */
- (NSString *)getHtmlStringAtSection:(NSUInteger)section andRow:(NSUInteger)row
{
    return [_responseArray[section][row] objectForKey:@"html_code"];
}

/**
 Получить родительский цвет выбранного цвета

 @param section 0 - задний план, 1 - передний план, 2 - изображение
 @param row номер цвета по порядку
 @return строка с названием родительского цвета
 */
- (NSString *)getParentColorAtSection:(NSUInteger)section andRow:(NSUInteger)row
{
    return [_responseArray[section][row] objectForKey:@"closest_palette_color_parent"];
}

/**
 Получить HTML код родительского цвета

 @param section 0 - задний план, 1 - передний план, 2 - изображение
 @param row номер цвета по порядку
 @return строка с HTML кодом родительского цвета
 */
- (NSString *)getHtmlParentColorAtSection:(NSUInteger)section andRow:(NSUInteger)row
{
    return [_responseArray[section][row] objectForKey:@"closest_palette_color_html_code"];
}

/**
 Получить ближайший похожий цвет к данному

 @param section 0 - задний план, 1 - передний план, 2 - изображение
 @param row номер цвета по порядку
 @return строка с названием ближайшего похожего цвета
 */
- (NSString *)getPaletteColorAtSection:(NSUInteger)section andRow:(NSUInteger)row
{
    return [_responseArray[section][row] objectForKey:@"closest_palette_color"];
}

/**
 Строка с числом, которое показывает процент содержания данного цвета во всем изображении

 @param section 0 - задний план, 1 - передний план, 2 - изображение
 @param row номер цвета по порядку
 @return строка с процентным содержанием
 */
- (NSString *)getPercentAtSection:(NSUInteger)section andRow:(NSUInteger)row
{
    return [_responseArray[section][row] objectForKey:@"percent"];
}

/**
 Число с красной составляющей цвета

 @param section 0 - задний план, 1 - передний план, 2 - изображение
 @param row номер цвета по прядку
 @return нормированное число с красной составляющей цвета
 */
- (float)getRedValueAtSection:(NSUInteger)section andRow:(NSUInteger)row
{
    return [[_responseArray[section][row] objectForKey:@"r"] floatValue]/255.f;
}

/**
 Число с зеленой составляющей цвета
 
 @param section 0 - задний план, 1 - передний план, 2 - изображение
 @param row номер цвета по прядку
 @return нормированное число с зеленой составляющей цвета
 */
- (float)getGreenValueAtSection:(NSUInteger)section andRow:(NSUInteger)row
{
    return [[_responseArray[section][row] objectForKey:@"g"] floatValue]/255.f;
}

/**
 Число с синей составляющей цвета
 
 @param section 0 - задний план, 1 - передний план, 2 - изображение
 @param row номер цвета по прядку
 @return нормированное число с синей составляющей цвета
 */
- (float)getBlueValueAtSection:(NSUInteger)section andRow:(NSUInteger)row
{
    return [[_responseArray[section][row] objectForKey:@"b"] floatValue]/255.f;
}

/**
 Получить строку с названием MenuView по индексу

 @param row индекс
 @return строка с названием конкретного столбца
 */
- (NSString *)getClassicCellString:(NSUInteger)row
{
    return [_responseArray objectAtIndex:row];
}

/**
 Количество строк в секции (цвета)

 @param section номер секции 0 - задний план, 1 - передний план, 2 - изображение
 @return количество строк в секции
 */
- (NSUInteger)getRowsInSectionCount:(NSUInteger)section
{
    return [_responseArray[section] count];
}

/**
 Количство строк (тэги, классификация)

 @return количество строк
 */
- (NSUInteger)getRows
{
    return _responseArray.count;
}

/**
 Очистка TableView
 */
- (void)clearTableView
{
    self.responseArray = nil;
}

#pragma mark - CollectionViewCoreData

/**
 Количство сохраненных изображений в CoreData

 @return количество сохраненных изображений
 */
- (NSUInteger)getCount
{
    return self.coreDataImagesArray.count;
}

/**
 Получить изображение из CoreData по индексу

 @param index номер изображение
 @return сохраненное изображение в формате NSData по индексу
 */
- (NSData *)getImageAtIndex:(NSUInteger)index
{
    Images *image = self.coreDataImagesArray[index];
    return image.image;
}

/**
 В сохраненных изображениях при нажатии на изображение, получаем его и делвем во весь экран

 @param index индекс изображения в CollectionView CoreData
 */
- (void)cellAtIndexWasPressed:(NSUInteger)index
{
    self.imageCoreData = [self getImageAtIndex:index];
    [self.router pushViewController:self.passiveViewFullImage];
}

/**
 Получить сохраненное изображение размером во весь экран

 @return изображение во весь экран в формате NSData
 */
- (NSData *)getFullScreenImage
{
    return _imageCoreData;
}

/**
 При нажатии кнопки Назад, вынимаем ViewController из NavigationControllera
 */
- (void)backButtonWasPressed
{
    [self.router popViewController];
}

@end
