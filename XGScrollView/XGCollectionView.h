//
//  XGCollectionView.h
//  XGScrollView
//
//  Created by vsKing on 2017/2/22.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGCollectionView : UICollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout imageUrls:(NSArray<NSString *> *)imageUrls;

@end
