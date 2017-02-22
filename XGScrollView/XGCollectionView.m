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

@property (nonatomic, strong) NSTimer *timer;

@end



@implementation XGCollectionView



- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout * _Nonnull)layout imageUrls:(NSArray<NSString *> *)imageUrls
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        _imageUrls = imageUrls;
        
        
        [self registerClass:[ImageCell class] forCellWithReuseIdentifier:NSStringFromClass([ImageCell class])];
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.contentOffset = CGPointMake(frame.size.width, 0);
        
        self.delegate = self;
        self.dataSource = self;
        
        if (imageUrls.count == 1) {
            [self setScrollEnabled:NO];
        }
        
        
    }
    return self;
}


- (void)start{
    self.isRuning = YES;
    if ([self.imageUrls count] >1) {
        [self addTimer];
    }
}

- (void)stop{
    self.isRuning = NO;
    if ([self.imageUrls count] > 1) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


- (void) addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)nextPage{
    
    [self setContentOffset:CGPointMake(self.contentOffset.x + self.frame.size.width, 0) animated:YES];
    
    
}

- (void)scrollViewDidFinish{
    
    CGPoint lastImagePoint = CGPointMake(([self.imageUrls count]+1)*self.frame.size.width, 0);
    
    if (self.contentOffset.x == lastImagePoint.x) {
        //  已经是最后一张
        NSLog(@"已经是最后一张,直接跳到第二张");
        [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    }else if (self.contentOffset.x == 0){
        NSLog(@"现在是第一张，跳到倒数第二张");
        [self setContentOffset:CGPointMake(self.frame.size.width*self.imageUrls.count, 0) animated:NO];
    }
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
    cell.row = (int)indexPath.row;
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"即将开始拖动");
    
    if ([self.imageUrls count] > 1) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"结束拖动");
    if ([self.imageUrls count] > 1) {
        [self addTimer];
    }
    
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"滚动动画 已经完成");
    [self scrollViewDidFinish];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"滚动停止");
    [self scrollViewDidFinish];
}

@end
