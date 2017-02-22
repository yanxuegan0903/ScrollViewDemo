//
//  XMRTimePiker.h
//  时间选择器
//
//  Created by xiaxing on 16/7/19.
//  Copyright © 2016年 xiaxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSNumber+GetNumber.h"


@protocol XMRTimePikerDelegate <NSObject>

- (void)XMSelectTimesViewSetOneLeft:(NSString *)oneLeft andOneRight:(NSString *)oneRight andTowLeft:(NSString *)towLeft andTowRight:(NSString *)towRight;


-(void)clickBack;

@end

@interface XMRTimePiker : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,weak)id <XMRTimePikerDelegate> delegate;

@property(nonatomic,assign)BOOL is_houseKeeping;

-(instancetype)initWithTitleText:(NSString*)titleText;

-(void)showTime;

- (void)SetOldShowTimeOneLeft:(NSString *)oneLeft andOneRight:(NSString *)oneRight andTowLeft:(NSString *)towLeft andTowRight:(NSString *)towRight;

@end
