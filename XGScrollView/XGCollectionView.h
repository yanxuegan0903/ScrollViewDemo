//
//  XGCollectionView.h
//  XGScrollView
//
//  Created by vsKing on 2017/2/22.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGCollectionView : UICollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:( UICollectionViewLayout * _Nonnull )layout imageUrls:(NSArray<NSString *> *)imageUrls placeHolder:(NSString*)placeHolder duration:(CGFloat)duration;


- (void)start;

- (void)stop;

@property(nonatomic,assign)BOOL isRuning;


@end
