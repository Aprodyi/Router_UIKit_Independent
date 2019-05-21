//
//  StartScreenTests.m
//  Final_Project_MVPTests
//
//  Created by Вова on 09.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "SBSDataModel.h"
#import "SBSRouter.h"
#import "SBSPresenter.h"
#import "SBSStartScreenView.h"
#import "SBSImagePhotoView.h"
#import "SBSMenuView.h"
#import "SBSCropImageView.h"
#import "SBSCollectionView.h"
#import "SBSTableView.h"
#import "ColorsDictionary.h"

@interface PresenterTests : XCTestCase

@property (nonatomic, strong) SBSPresenter *presenter;

@property (nonatomic, strong) id mockRouter;
@property (nonatomic, strong) id mockDataModel;
@property (nonatomic, strong) id mockImagePhotoView;
@property (nonatomic, strong) id mockMenuView;
@property (nonatomic, strong) id mockTableView;
@property (nonatomic, strong) id mockCropView;

@end

@implementation PresenterTests

- (void)setUp
{
    self.presenter = [SBSPresenter new];
    self.mockRouter = OCMClassMock([SBSRouter class]);
    self.mockDataModel = OCMClassMock([SBSDataModel class]);
    self.mockImagePhotoView = OCMClassMock([SBSImagePhotoView class]);
    self.mockMenuView = OCMClassMock([SBSMenuView class]);
    self.mockTableView = OCMClassMock([SBSTableView class]);
    self.mockCropView = OCMClassMock([SBSCropImageView class]);
    
    self.presenter.router = self.mockRouter;
    self.presenter.model = self.mockDataModel;
    self.presenter.passiveViewImagePhoto = self.mockImagePhotoView;
    self.presenter.passiveViewMenu = self.mockMenuView;
    self.presenter.passiveViewTable = self.mockTableView;
    self.presenter.passiveViewCropImage = self.mockCropView;
}

- (void)testImageScreenButtonPressed
{
    //arrange
    
    //act
    [self.presenter createImageScreenButtonWasPressed];
    
    //assert
    OCMVerify([self.mockRouter pushViewController:self.mockImagePhotoView]);
}

- (void)testImagePickIsDoneWithDataNotNil
{
    //arrange
    
    //act
    uint32_t dataBytes = 0xABCD;
    NSData *imagePickData = [NSData dataWithBytes:&dataBytes length:sizeof(dataBytes)];
    [self.presenter imagePickIsDoneWithData:imagePickData];
    
    //assert
    OCMVerify([self.mockImagePhotoView createNextButton]);
    OCMVerify([self.mockDataModel saveImageData:imagePickData]);
    OCMVerify([self.mockImagePhotoView uploadImageData:imagePickData]);
}

- (void)testNextButtonWasPressed
{
    //arrange
    
    //act
    [self.presenter nextButtonWasPressed];
    
    //assert
    OCMVerify([self.mockRouter pushViewController:self.mockMenuView]);
}

- (void)testGetArrayCountIsEqualNilArray
{
    //arrange
    NSArray *nilArray = nil;
    OCMStub([self.mockDataModel getProcessingArray]).andReturn(nilArray);
    
    //act
    
    //assert
    XCTAssertFalse(nilArray);
}

- (void)testGetArrayCountIsEqualEmptyArray
{
    //arrange
    NSArray *emptyArray = @[];
    OCMStub([self.mockDataModel getProcessingArray]).andReturn(emptyArray);
    
    //act
    NSInteger count = [self.presenter getArrayCount];
    
    //assert
    XCTAssertEqual(count, 0);
}

- (void)testGetArrayCountIsEqualArrayWithData
{
    //arrange
    NSArray *arrayWithFiveElements = @[@"1", @"2", @"3", @"4", @"5"];
    OCMStub([self.mockDataModel getProcessingArray]).andReturn(arrayWithFiveElements);
    
    //act
    NSInteger count = [self.presenter getArrayCount];
    
    //assert
    XCTAssertEqual(count, 5);
}

- (void)testgetTextAtIndexWithDataArray
{
    //arrange
    NSArray *array = @[@"Первый элемент", @"Второй элемент", @"Третий элемент", @"Четвертый элемент"];
    OCMStub([self.mockDataModel getProcessingArray]).andReturn(array);
    
    //act
    NSString *first = [self.presenter getTextAtIndex:0];
    NSString *second = [self.presenter getTextAtIndex:1];
    NSString *third = [self.presenter getTextAtIndex:2];
    NSString *fourth = [self.presenter getTextAtIndex:3];
    
    //assert
    XCTAssertEqual(first, @"Первый элемент");
    XCTAssertEqual(second, @"Второй элемент");
    XCTAssertEqual(third, @"Третий элемент");
    XCTAssertEqual(fourth, @"Четвертый элемент");
}

- (void)testgetTextAtIndexWithExitArrayRange
{
    //arrange
    NSArray *array = @[];
    OCMStub([self.mockDataModel getProcessingArray]).andReturn(array);
    
    //act
    NSString *exitRangeArray = [self.presenter getTextAtIndex:99999];

    //assert
    XCTAssertEqualObjects(exitRangeArray, @"Выход за границы массива");
}

- (void)testLabelWasPressedAtFirstLabel
{
    //arrange
    NSArray *array = @[@"Первый", @"Второй", @"Третий", @"Четвертый"];
    OCMStub([self.mockDataModel getProcessingArray]).andReturn(array);
    
    //act
    [self.presenter labelWasPressed:@"Первый"];
    
    //assert
    OCMVerify([self.mockRouter pushViewController:self.mockTableView]);
    OCMVerify([self.mockDataModel getTags]);
}

- (void)testLabelWasPressedAtSecondLabel
{
    //arrange
    NSArray *array = @[@"Первый", @"Второй", @"Третий", @"Четвертый"];
    OCMStub([self.mockDataModel getProcessingArray]).andReturn(array);
    
    //act
    [self.presenter labelWasPressed:@"Второй"];
    
    //assert
    OCMVerify([self.mockRouter pushViewController:self.mockTableView]);
    OCMVerify([self.mockDataModel getCategories]);
}

- (void)testLabelWasPressedAtThirdLabel
{
    //arrange
    NSArray *array = @[@"Первый", @"Второй", @"Третий", @"Четвертый"];
    OCMStub([self.mockDataModel getProcessingArray]).andReturn(array);
    
    //act
    [self.presenter labelWasPressed:@"Третий"];
    
    //assert
    OCMVerify([self.mockRouter pushViewController:self.mockCropView]);
    OCMVerify([self.mockDataModel getCropImage]);
}

- (void)testLabelWasPressedAtFourthLabel
{
    //arrange
    NSArray *array = @[@"Первый", @"Второй", @"Третий", @"Четвертый"];
    OCMStub([self.mockDataModel getProcessingArray]).andReturn(array);
    
    //act
    [self.presenter labelWasPressed:@"Четвертый"];
    
    //assert
    OCMVerify([self.mockRouter pushViewController:self.mockTableView]);
    OCMVerify([self.mockDataModel getColors]);
}

- (void)testLoadingCropIsDoneWithDataRecieved
{
    //arrange
    NSDictionary *responseDictionary = @{
        @"result": @{
            @"croppings": @[
                          @{
                              @"target_height": @(100),
                              @"target_width": @(100),
                              @"x1": @(59),
                              @"x2": @(507),
                              @"y1": @(0),
                              @"y2": @(448)
                          },
                          @{
                              @"target_height": @(300),
                              @"target_width": @(500),
                              @"x1": @(0),
                              @"x2": @(639),
                              @"y1": @(0),
                              @"y2": @(384)
                          }
                          ]
        },
        @"status": @{
            @"text": @"",
            @"type": @"success"
        }
    };
    
    //act
    [self.presenter loadingCropIsDoneWithDataRecieved:responseDictionary];
    
    //assert
    OCMVerify([self.mockCropView cropRectWithX:59 andY:0 andHeight:100 andWidth:100]);
}

- (void)testUploadTableViewWithTagsDictIsEqualDataArray
{
    //arrange
    NSArray *tagConfidenceArray = @[@"гора - 61", @"ландшафт - 54", @"горы - 50", @"стена - 46"];
    NSDictionary *responseDictionary = @{
        @"result": @{
            @"tags": @[
                     @{
                         @"confidence": @(61),
                         @"tag": @{
                             @"ru": @"гора"
                         }
                     },
                     @{
                         @"confidence": @(54),
                         @"tag": @{
                             @"ru": @"ландшафт"
                         }
                     },
                     @{
                         @"confidence": @(50),
                         @"tag": @{
                             @"ru": @"горы"
                         }
                     },
                     @{
                         @"confidence": @(46),
                         @"tag": @{
                             @"ru": @"стена"
                         }
                     }
                ]
        },
        @"status": @{
            @"text": @"",
            @"type": @"success"
        }
    };
    
    //act
    [self.presenter uploadTableViewWithTagsDict:responseDictionary];
    
    //assert
    XCTAssertEqualObjects(self.presenter.responseArray, tagConfidenceArray);
    OCMVerify([self.mockTableView reloadTableViewWithIdentifier:@"Tags"]);
}

- (void)testUploadTableViewWithTagsDictIsEqualNilData
{
    //arrange
    NSDictionary *responseDictionary = @{
                                         @"result": @{ /* ... */ },
                                         @"status": @{
                                                 @"text": @"human-readble description",
                                                 @"type": @"error"
                                                 }
                                         };
    
    //act
    [self.presenter uploadTableViewWithTagsDict:responseDictionary];
    
    //assert
    XCTAssertNil(self.presenter.responseArray);
}

- (void)testUploadTableViewWithCategoriesDictIsEqualDataArray
{
    //arrange
    NSArray *categoriesConfidenceArray = @[@"Уличная архитектура - 99.9469680786133"];
    NSDictionary *responseDictionary = @{
        @"result": @{
            @"categories": @[
                    @{
                        @"confidence": @(99.9469680786133),
                        @"name": @{
                            @"ru": @"Уличная архитектура"
                    }
                }
            ]
        },
        @"status": @{
            @"text": @"",
            @"type": @"success"
        }
    };
    
    //act
    [self.presenter uploadTableViewWithCategoriesDict:responseDictionary];
    
    //assert
    XCTAssertEqualObjects(self.presenter.responseArray, categoriesConfidenceArray);
    OCMVerify([self.mockTableView reloadTableViewWithIdentifier:@"Categories"]);
}

- (void)testUploadTableViewWithCategoriessDictIsEqualNilData
{
    //arrange
    NSDictionary *responseDictionary = @{
                                         @"result": @{ /* ... */ },
                                         @"status": @{
                                                 @"text": @"human-readble description",
                                                 @"type": @"error"
                                                 }
                                         };
    
    //act
    [self.presenter uploadTableViewWithCategoriesDict:responseDictionary];
    
    //assert
    XCTAssertNil(self.presenter.responseArray);
}

- (void)testUploadTableViewWithColorsDictIsEqualDataArray
{
    //arrange
    NSArray *backgroundColors = [ColorsDictionary getBackgroundColorsArray];
    NSArray *foregroundColors = [ColorsDictionary getForegroundColorsArray];
    NSArray *imageColors = [ColorsDictionary getImageColorsArray];
    NSArray *responseColorsArray = [NSArray arrayWithObjects: backgroundColors, foregroundColors, imageColors, nil];
    NSDictionary *responseDictionary = [ColorsDictionary getConstDictionary];
    
    //act
    [self.presenter uploadTableViewWithColorsDict:responseDictionary];
    
    //assert
    XCTAssertEqualObjects(self.presenter.responseArray, responseColorsArray);
}

- (void)testUploadTableViewWithColorsDictIsEqualNilData
{
    //arrange
    NSDictionary *responseDictionary = @{
                                         @"result": @{ /* ... */ },
                                         @"status": @{
                                                 @"text": @"human-readble description",
                                                 @"type": @"error"
                                                 }
                                         };
    
    //act
    [self.presenter uploadTableViewWithColorsDict:responseDictionary];
    
    //assert
    XCTAssertNil(self.presenter.responseArray);
}

@end
