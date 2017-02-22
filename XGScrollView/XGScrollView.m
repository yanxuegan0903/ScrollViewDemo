//
//  XGScrollView.m
//  XGScrollView
//
//  Created by vsKing on 2017/2/21.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "XGScrollView.h"
#import "UIImageView+WebCache.h"


@interface XGScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray<NSString *> *imageUrls;
@property (nonatomic, strong) UIImage *placeHolder;
@property (nonatomic, strong) NSTimer *timer;
@property(nonatomic,assign)CGFloat duration;



@end


@implementation XGScrollView


- (instancetype)initWithFrame:(CGRect)frame Images:(NSArray<NSString*> *)imageUrls placeHolder:(UIImage *)placeHolder duration:(CGFloat)duration
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (!duration || duration <= 0) {
            self.duration = 3.0;
        }else{
            self.duration = duration;
        }
        
        if (!placeHolder) {
            NSLog(@"Error: placeHolder __nonnull");
        }
        
        
        
        
        self.imageUrls = imageUrls;
        self.placeHolder = placeHolder;
        
        [self initInterNetUI];
        
        
        
    }
    return self;
}


- (void)initInterNetUI{
    
    //第一张图片(向前拖拽，为了循环，第一张图应该和显示的最后一张图一样)
    UIImageView *firstImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [firstImage sd_setImageWithURL:[NSURL URLWithString:[self.imageUrls lastObject]] placeholderImage:_placeHolder];
    [self addSubview:firstImage];
    
    //最后一张图片(向后拖拽，为了循环，最后一张图应该和显示的第一张图一样)
    UIImageView *lastImage = [[UIImageView alloc] initWithFrame:CGRectMake(([self.imageUrls count] + 1) * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [lastImage sd_setImageWithURL:[NSURL URLWithString:[self.imageUrls firstObject]] placeholderImage:_placeHolder];
    [self addSubview:lastImage];
    
    //第二张图 → 倒数第二张图
    for (NSInteger i = 0; i < [self.imageUrls count]; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * (i + 1), 0, self.frame.size.width, self.frame.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[self.imageUrls objectAtIndex:i]] placeholderImage:_placeHolder];
        [self addSubview:imageView];
    }
    
    
    self.contentOffset = CGPointMake(self.frame.size.width, 0);
    self.contentSize = CGSizeMake(self.frame.size.width * ([self.imageUrls count]+2), self.frame.size.height);
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.bounces = YES;
    self.delegate = self;
    
    
//    if ([self.imageUrls count] > 1) {
//        [self addTimer];
//    }
    
    
}


- (void)start{
    
    self.isRuning = YES;
    if ([self.imageUrls count] > 1) {
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
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
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


#pragma mark - ScrollViewDelegate

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
