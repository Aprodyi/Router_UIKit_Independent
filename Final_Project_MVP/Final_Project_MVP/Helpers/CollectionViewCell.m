//
//  CollectionViewCell.m
//  Final_Project_MVP
//
//  Created by Вова on 07.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.cornerRadius = 10.0;
        self.layer.borderWidth = 4.0;
        self.contentView.layer.cornerRadius = 10.0;
        self.contentView.layer.masksToBounds = YES;
        self.imageView = [UIImageView new];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

@end
