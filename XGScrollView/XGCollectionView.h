//
//  XGCollectionView.h
//  XGScrollView
//
//  Created by vsKing on 2017/2/21.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGCollectionView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray <UIImage *> *)images;


@end
