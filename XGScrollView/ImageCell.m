//
//  ImageCell.m
//  XGScrollView
//
//  Created by vsKing on 2017/2/21.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation ImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
    
}


- (void)setImage:(UIImage *)image{
    _image = image;
    
    [self.imageView setImage:image];
    
    
}




@end
