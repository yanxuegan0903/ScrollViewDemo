//
//  XGCollectionView.m
//  XGScrollView
//
//  Created by vsKing on 2017/2/21.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "XGCollectionView.h"
#import "ImageCell.h"


@interface XGCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray<UIImage *> *images;
@property (nonatomic, strong) NSTimer *timer;


@end


@implementation XGCollectionView


- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray<UIImage *> *)images
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.images = images;
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        [self addSubview:collectionView];
        [collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:NSStringFromClass([ImageCell class])];
        collectionView.backgroundColor = [UIColor redColor];
        collectionView.contentOffset = CGPointMake(0, 0);
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.pagingEnabled = YES;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView = collectionView;
        
        [self addTimer];
        
    }
    return self;
}

#pragma mark - collectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.images count]+1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ImageCell class]) forIndexPath:indexPath];
    
    if (indexPath.row == self.images.count) {
        cell.image = [self.images firstObject];
        return cell;
    }
    
    cell.image = [self.images objectAtIndex:indexPath.row];
    
    return cell;
    
}


- (void) addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)nextPage{
    
    
    
    
//    CGPoint lastImagePoint = CGPointMake(([self.images count])*self.frame.size.width, 0);
    
//    if (self.collectionView.contentOffset.x == lastImagePoint.x) {
//        //  已经是最后一张
//        NSLog(@"已经是最后一张,直接跳到第一张");
//        //        [self scrollRectToVisible:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) animated:YES];
//        
//        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
//        
//        
//        return ;
//    }
    
    [self.collectionView scrollRectToVisible:CGRectMake(self.collectionView.contentOffset.x + self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:YES];
    
    
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"即将开始拖动");
    
    if ([self.images count] > 1) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"结束拖动");
    if ([self.images count] > 1) {
        [self addTimer];
    }
    
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"滚动动画 已经完成");
    [self collectionDidFinish];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"滚动停止");
    
    [self collectionDidFinish];
    
}


- (void)collectionDidFinish{
    CGPoint lastImagePoint = CGPointMake(([self.images count]+1)*self.frame.size.width, 0);
    
    if (self.collectionView.contentOffset.x == lastImagePoint.x) {
//        [self.collectionView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
//        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
//        [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
        
//        [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForRow:self.images.count inSection:0] toIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
}




@end
