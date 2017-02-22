//
//  ImageCell.h
//  XGScrollView
//
//  Created by vsKing on 2017/2/22.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCell : UICollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) UIImage *placeHolder;
@property(nonatomic,assign)int row;




@end
