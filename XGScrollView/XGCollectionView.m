//
//  XGCollectionView.m
//  XGScrollView
//
//  Created by vsKing on 2017/2/22.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "XGCollectionView.h"
#import "ImageCell.h"


@interface XGCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray<NSString *> *imageUrls;



@end



@implementation XGCollectionView



- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout imageUrls:(NSArray<NSString *> *)imageUrls
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        _imageUrls = imageUrls;
        
        
        [self registerClass:[ImageCell class] forCellWithReuseIdentifier:NSStringFromClass([ImageCell class])];
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.dataSource = self;
        
        
        
        
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSections{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.imageUrls count] +2;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageCell * cell = [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ImageCell class]) forIndexPath:indexPath];
    cell.placeHolder = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1.jpeg" ofType:nil]];
    
    if (indexPath.row == 0) {
        //  第一个cell 显示最后一张图
        
        cell.imageUrl = [self.imageUrls objectAtIndex:[self.imageUrls count] -1];
        
        
    }else if (indexPath.row == [self.imageUrls count] +1){
        //  最后一个cell 显示第一张图
        cell.imageUrl = [self.imageUrls objectAtIndex:0];

    }else{
        //  中间的cell
        cell.imageUrl = [self.imageUrls objectAtIndex:indexPath.row -1];
    }
        
    return cell;
}





#pragma mark - UICollectionViewDelegate


@end
