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
@property (nonatomic, strong) UILabel *label;

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
    
    
    UILabel * label = [UILabel new];
    label.backgroundColor = [UIColor greenColor];
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:24];
    label.text = @"NNN";
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    [self addSubview:label];
    self.label = label;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
}


- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:_placeHolder];
}


- (void)setRow:(int)row{
    _row = row;
    
    NSLog(@"设置Row");
    
    self.label.text = [NSString stringWithFormat:@"%d",row];
    
}




@end
