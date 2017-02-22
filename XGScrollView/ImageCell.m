//
//  ImageCell.m
//  XGScrollView
//
//  Created by vsKing on 2017/2/22.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "ImageCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface ImageCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation ImageCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor redColor];
        
        [self initUI];
        
        
    }
    return self;
}

- (void)initUI{
    
    UIImageView * imageView = [UIImageView new];
    [self addSubview:imageView];
    self.imageView = imageView;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    

}


- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:_placeHolder];
}





@end
