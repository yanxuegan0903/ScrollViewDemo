//
//  XGScrollView.h
//  XGScrollView
//
//  Created by vsKing on 2017/2/21.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGScrollView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame Images:(NSArray<NSString*> *)imageUrls placeHolder:(UIImage *)placeHolder duration:(CGFloat)duration;

- (void)start;
- (void)stop;

@property(nonatomic,assign)BOOL isRuning;




@end
