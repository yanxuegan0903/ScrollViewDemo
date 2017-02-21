//
//  XGScrollView.m
//  XGScrollView
//
//  Created by vsKing on 2017/2/21.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "XGScrollView.h"

@interface XGScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray<UIImage *> *images;

@property (nonatomic, strong) NSTimer *timer;

@end


@implementation XGScrollView


- (instancetype)initWithImages:(NSArray<UIImage*> *)images
{
    self = [super init];
    if (self) {
        
        self.images = images;
        
        [self initUI];
        
        
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame images:(NSArray <UIImage *>*)images{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.images = images;
        [self initUI];
    }
    
    return self;
    
}


- (void)initUI{
    
    //第一张图片(向前拖拽，为了循环，第一张图应该和显示的最后一张图一样)
    UIImageView *firstImage = [[UIImageView alloc] initWithImage:[self.images lastObject]];
    firstImage.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:firstImage];
    
    //最后一张图片(向后拖拽，为了循环，最后一张图应该和显示的第一张图一样)
    UIImageView *lastImage = [[UIImageView alloc] initWithImage:[self.images firstObject]];
    lastImage.frame = CGRectMake(([self.images count] + 1) * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:lastImage];
    
    //第二张图 → 倒数第二张图
    for (NSInteger i = 0; i < [self.images count]; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[self.images objectAtIndex:i]];
        imageView.frame = CGRectMake(self.frame.size.width * (i + 1), 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:imageView];
    }
    
    
    self.contentOffset = CGPointMake(self.frame.size.width, 0);
    self.contentSize = CGSizeMake(self.frame.size.width * ([self.images count]+2), self.frame.size.height);
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.bounces = YES;
    self.delegate = self;
    
    
    if ([self.images count] > 1) {
        [self addTimer];
    }
    
    
}

- (void) addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)nextPage{
   
    [self scrollRectToVisible:CGRectMake(self.contentOffset.x + self.frame.size.width , 0, self.frame.size.width, self.frame.size.width) animated:YES];
    
    
}


- (void)scrollViewDidFinish{
    
    CGPoint lastImagePoint = CGPointMake(([self.images count]+1)*self.frame.size.width, 0);
    
    if (self.contentOffset.x == lastImagePoint.x) {
        //  已经是最后一张
        NSLog(@"已经是最后一张,直接跳到第二张");
        [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    }else if (self.contentOffset.x == 0){
        NSLog(@"现在是第一张，跳到倒数第二张");
        [self setContentOffset:CGPointMake(self.frame.size.width*self.images.count, 0) animated:NO];
    }
}


#pragma mark - ScrollViewDelegate

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
    [self scrollViewDidFinish];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"滚动停止");
    [self scrollViewDidFinish];
}





@end
