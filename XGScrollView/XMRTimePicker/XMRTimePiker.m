//
//  XMRTimePiker.m
//  时间选择器
//
//  Created by xiaxing on 16/7/19.
//  Copyright © 2016年 xiaxing. All rights reserved.
//

#import "XMRTimePiker.h"
#import "Masonry.h"



#define selfGreen [UIColor colorWithRed:69/255.0 green:181/255.0 blue:55/255.0 alpha:0.8]
//iPhone 6
#define self6WidthRate [UIScreen mainScreen].bounds.size.width/375.0

#define selfBacground [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

#define selfWidth [UIScreen mainScreen].bounds.size.width

#define selfHeight [UIScreen mainScreen].bounds.size.height

#define selfWidthRate [UIScreen mainScreen].bounds.size.width/320.0

#define selfHeightRate [UIScreen mainScreen].bounds.size.height/568.0

#define self6WidthRate [UIScreen mainScreen].bounds.size.width/375.0

#define self6HeightRate [UIScreen mainScreen].bounds.size.height/667.0
//颜色16进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1]

#define XMRECT6(rect) CGRectMake(rect.origin.x*self6WidthRate, rect.origin.y*self6HeightRate, rect.size.width*self6WidthRate, rect.size.height*self6HeightRate)

#define XMRECT(rect) CGRectMake(rect.origin.x*selfWidthRate, rect.origin.y*selfHeightRate, rect.size.width*selfWidthRate, rect.size.height*selfHeightRate)


@interface XMRTimePiker ()

@property (nonatomic, strong) UIView *white_view;
@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) UILabel *green_dian;
@property (nonatomic, strong) UILabel *red_dian;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UILabel *toLabel;

@property (nonatomic, strong) UIView *lineLeftUp;
@property (nonatomic, strong) UIView *lineleftDown;
@property (nonatomic, strong) UIView *lineRightUP;
@property (nonatomic, strong) UIView *lineRightDown;
@property (nonatomic, strong) UIView *viewUP;
@property (nonatomic, strong) UIView *viewDown;
@property (nonatomic, strong) NSString *titleText;

@end



@implementation XMRTimePiker{
    
    //    row
    NSInteger left0_row;
    NSInteger left1_row;
    NSInteger right0_row;
    NSInteger right1_row;
    // pickerView
    
    UIPickerView * _pickerView_left;
    // pickerView
    
    UIPickerView * _pickerView_right;
    // 小时
    
    NSMutableArray * _hours_Arr;
    // 分钟
    NSMutableArray * _min_arr;
   
}

-(instancetype)initWithTitleText:(NSString*)titleText
{
    
   self=[super init];
    
    if (self)
    {
        self.titleText = titleText;
        _min_arr  = [NSMutableArray arrayWithCapacity:60];
        _hours_Arr = [NSMutableArray arrayWithCapacity:24];
        
        for (int i = 0; i < 60; i++)
        {
            NSString * str = [NSString stringWithFormat:@"%02d",i];
            
            if (i<24)
            {
                [_hours_Arr addObject:str];
            }
            [_min_arr addObject:str];
        }
        
        self.frame=CGRectMake(0, selfHeight, selfWidth, selfHeight);
        self.backgroundColor = [UIColor clearColor];
        
        [self createUI];
    }

    return self;

}

-(void)layoutSubviews
{
    [self.white_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo([NSNumber getTransNumberCompareHeight:1000]);
        make.width.mas_equalTo([NSNumber getTransNumberCompareWidth:800]);
        make.top.mas_equalTo([NSNumber getTransNumberCompareHeight:520]);
    }];
    
    [self.viewUP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.white_view.mas_left);
        make.right.mas_equalTo(self.white_view.mas_right);
        make.top.mas_equalTo(self.white_view.mas_top);
        make.height.mas_equalTo([NSNumber getTransNumberCompareHeight:172]);
    }];
    
    [self.viewDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.white_view.mas_left);
        make.right.mas_equalTo(self.white_view.mas_right);
        make.bottom.mas_equalTo(self.white_view.mas_bottom);
        make.height.mas_equalTo([NSNumber getTransNumberCompareHeight:210]);
    }];
    
    
    [self.title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo([NSNumber getTransNumberCompareHeight:50]);
    }];
    
    [_pickerView_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([NSNumber getTransNumberCompareHeight:450]);
        make.width.mas_equalTo([NSNumber getTransNumberCompareWidth:300]);
        make.left.mas_equalTo(self.white_view.mas_left).offset([NSNumber getTransNumberCompareWidth:50]);
        make.top.mas_equalTo(self.white_view.mas_top).offset([NSNumber getTransNumberCompareHeight:255]);
    }];
    
    [_pickerView_right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([NSNumber getTransNumberCompareHeight:450]);
        make.width.mas_equalTo([NSNumber getTransNumberCompareWidth:300]);
        make.top.mas_equalTo(self.white_view.mas_top).offset([NSNumber getTransNumberCompareHeight:255]);
        make.right.mas_equalTo(self.white_view.mas_right).offset(-[NSNumber getTransNumberCompareWidth:50]);
    }];
    
    [self.green_dian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_pickerView_left.mas_centerX);
        make.centerY.mas_equalTo(_pickerView_left.mas_centerY);
    }];
    
    [self.red_dian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_pickerView_right.mas_centerY);
        make.centerX.mas_equalTo(_pickerView_right.mas_centerX);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.white_view.mas_centerX);
        make.left.mas_equalTo(self.white_view.mas_left).offset([NSNumber getTransNumberCompareWidth:60]);
        make.height.mas_equalTo([NSNumber getTransNumberCompareHeight:140]);
        make.bottom.mas_equalTo(self.white_view.mas_bottom).offset(-[NSNumber getTransNumberCompareHeight:33]);
    }];
    
    [self.toLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_pickerView_right.mas_centerY);
        make.centerX.mas_equalTo(self.white_view.mas_centerX);
    }];
    
    [self.lineLeftUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.centerY.mas_equalTo(_pickerView_left.mas_centerY).offset(-[NSNumber getTransNumberCompareHeight:30]);
        make.left.mas_equalTo(_pickerView_left.mas_left).offset([NSNumber getTransNumberCompareWidth:30]);
        make.right.mas_equalTo(_pickerView_left.mas_right).offset(-[NSNumber getTransNumberCompareWidth:30]);
    }];
    
    [self.lineleftDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.centerY.mas_equalTo(_pickerView_left.mas_centerY).offset([NSNumber getTransNumberCompareHeight:30]);
        make.left.mas_equalTo(_pickerView_left.mas_left).offset([NSNumber getTransNumberCompareWidth:30]);
        make.right.mas_equalTo(_pickerView_left.mas_right).offset(-[NSNumber getTransNumberCompareWidth:30]);
    }];
    
    [self.lineRightUP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.centerY.mas_equalTo(_pickerView_right.mas_centerY).offset(-[NSNumber getTransNumberCompareHeight:30]);
        make.left.mas_equalTo(_pickerView_right.mas_left).offset([NSNumber getTransNumberCompareWidth:30]);
        make.right.mas_equalTo(_pickerView_right.mas_right).offset(-[NSNumber getTransNumberCompareWidth:30]);
    }];
    
    [self.lineRightDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.centerY.mas_equalTo(_pickerView_left.mas_centerY).offset([NSNumber getTransNumberCompareHeight:30]);
        make.left.mas_equalTo(_pickerView_right.mas_left).offset([NSNumber getTransNumberCompareWidth:30]);
        make.right.mas_equalTo(_pickerView_right.mas_right).offset(-[NSNumber getTransNumberCompareWidth:30]);
    }];
    
}


-(void)createUI{

    // 背景白色View
    UIView * white_view=[[UIView alloc]init];//WithFrame:XMRECT6(CGRectMake(50, 220,375-100, 300))];
    white_view.backgroundColor=[UIColor whiteColor];
    white_view.layer.cornerRadius=5;
    white_view.layer.masksToBounds = YES;
    self.white_view = white_view;
    [self addSubview:white_view];
    
    UIView * viewUP = [UIView new];
    [white_view addSubview:viewUP];
    viewUP.backgroundColor = [UIColor colorWithHex:0xeeeeee];
    self.viewUP = viewUP;
    
    UIView * viewDown = [UIView new];
    [white_view addSubview:viewDown];
    viewDown.backgroundColor = [UIColor colorWithHex:0xeeeeee];
    self.viewDown = viewDown;
    
    //选择时间标题
    UILabel * title_label=[[UILabel alloc]init];//WithFrame:XMRECT6(CGRectMake((275-150)/2, 21, 150, 30))];
    title_label.text= self.titleText;
    title_label.textColor=UIColorFromRGB(0x333333);//[UIColor colorWithHex:0x333333];
    title_label.textAlignment=NSTextAlignmentCenter;
    title_label.font = [UIFont systemFontOfSize:18];
    [white_view addSubview:title_label];
    self.title_label = title_label;
    
    
    
    //  选择营业时间   左边
    _pickerView_left=[[UIPickerView alloc]init];//WithFrame:XMRECT6(CGRectMake(30,100,100,130))];
    _pickerView_left.delegate=self;
    _pickerView_left.dataSource=self;
    _pickerView_left.backgroundColor=[UIColor whiteColor];//UIColorFromRGB(0xfbfbfb);
    [white_view addSubview:_pickerView_left];

    //  选择结束时间   右边
    _pickerView_right=[[UIPickerView alloc]init];//WithFrame:XMRECT6(CGRectMake(140,100,100,130))];
    _pickerView_right.delegate=self;
    _pickerView_right.dataSource=self;
    _pickerView_right.backgroundColor=[UIColor whiteColor];//UIColorFromRGB(0xfbfbfb);
    [white_view addSubview:_pickerView_right];

    
    
    //   选中的背景图绿色  中间绿色的 “:”
    UILabel * green_dian=[[UILabel alloc]init];//WithFrame:XMRECT(CGRectMake(70, 125,30,30))];
    green_dian.text=@":";
    green_dian.textColor=selfGreen;
    green_dian.font=[UIFont systemFontOfSize:14];
    [white_view addSubview:green_dian];
    self.green_dian = green_dian;
    
    
    //    选中背景图红色  中间红色的 “:”
    UILabel * red_dian=[[UILabel alloc]init];//WithFrame:XMRECT(CGRectMake(160, 125,30,30))];
    red_dian.text=@":";
    red_dian.textColor=[UIColor redColor];
    red_dian.font=[UIFont systemFontOfSize:14];
    [white_view addSubview:red_dian];
    self.red_dian = red_dian;
    
    
    // 设置按钮
    
    UIButton * button=[[UIButton alloc]init];//WithFrame:XMRECT6(CGRectMake(275/2*i,250,275/2, 50))];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [white_view addSubview:button];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    button.backgroundColor = [UIColor appThemeCyan];
    [button setTitle:kString(@"save_setting") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(timeClick) forControlEvents:UIControlEventTouchUpInside];
    self.confirmBtn = button;
    
    //  "到"
    UILabel * toLabel = [UILabel new];
    [white_view addSubview:toLabel];
    toLabel.textColor = [UIColor colorWithHex:0x666666];
    toLabel.text = @"到";
    toLabel.font = [UIFont systemFontOfSize:13];
    self.toLabel = toLabel;
    
    //  中间四条横线
    UIView * lineLeftUP = [UIView new];
    UIView * lineLeftDown = [UIView new];
    UIView * lineRightUP = [UIView new];
    UIView * lineRightDown = [UIView new];
    
    [white_view addSubview:lineLeftUP];
    [white_view addSubview:lineLeftDown];
    [white_view addSubview:lineRightUP];
    [white_view addSubview:lineRightDown];
    
    lineLeftUP.backgroundColor = [UIColor colorWithHex:0x666666];
    lineLeftDown.backgroundColor = lineLeftUP.backgroundColor;
    lineRightUP.backgroundColor = lineLeftUP.backgroundColor;
    lineRightDown.backgroundColor = lineLeftUP.backgroundColor;
    
    lineLeftUP.alpha = 0.5;
    lineLeftDown.alpha = lineLeftUP.alpha;
    lineRightDown.alpha = lineLeftUP.alpha;
    lineRightUP.alpha = lineLeftUP.alpha;
    
    self.lineLeftUp = lineLeftUP;
    self.lineleftDown = lineLeftDown;
    self.lineRightUP = lineRightUP;
    self.lineRightDown = lineRightDown;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancel)];
    [self addGestureRecognizer:tap];
    
    
    
    
}
-(void)cancel{

    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(clickBack)])
    {
        [self.delegate clickBack];
    }
}
-(void)timeClick{
    
    int start_hour = [[_hours_Arr objectAtIndex:[_pickerView_left selectedRowInComponent:0]]intValue];
    int end_hour = [[_hours_Arr objectAtIndex:[_pickerView_right selectedRowInComponent:0]]intValue];
    int start_min = [[_min_arr objectAtIndex:[_pickerView_left selectedRowInComponent:1]] intValue];
    int end_min = [[_min_arr objectAtIndex:[_pickerView_right selectedRowInComponent:1]] intValue];

    int start_time = start_hour * 60 + start_min;
    int end_time = end_hour * 60 + end_min;

    if (_is_houseKeeping)
    {
        //  是看家时间设置
        
        if (start_time >= end_time)
        {
            //
            [[THud sharedInstance] showtips:kString(@"Time_setting_error")];
        }else
        {
            [self time];
        }
        
    }else
    {
        //  设置缩时拍时间
        if ((end_time - start_time) <= 30)
        {
            [[THud sharedInstance] showtips:kString(@"time_greater_than_30_minutes")];
        }else
        {
            [self time];
        }

    }
    
}
-(void)time{
    
    if (_delegate&&[_delegate respondsToSelector:@selector(XMSelectTimesViewSetOneLeft:andOneRight:andTowLeft:andTowRight:)]) {
        
        [self removeFromSuperview];
        NSString *OneLeft = [_hours_Arr objectAtIndex:[_pickerView_left selectedRowInComponent:0]];
        NSString *OneRight = [_min_arr objectAtIndex:[_pickerView_left selectedRowInComponent:1]];
        NSString *TowLeft = [_hours_Arr objectAtIndex:[_pickerView_right selectedRowInComponent:0]];
        NSString *TowRight = [_min_arr objectAtIndex:[_pickerView_right selectedRowInComponent:1]];
        
        [_delegate XMSelectTimesViewSetOneLeft:OneLeft andOneRight:OneRight andTowLeft:TowLeft andTowRight:TowRight];
        
    }
}

-(void)showTime{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        UIWindow * window=[UIApplication sharedApplication].keyWindow;
    
        self.frame=CGRectMake(0,0,selfWidth, selfHeight);
    
        [window addSubview:self];
        
    } completion:^(BOOL finished) {
       
        
    }];
}
- (void)SetOldShowTimeOneLeft:(NSString *)oneLeft andOneRight:(NSString *)oneRight andTowLeft:(NSString *)towLeft andTowRight:(NSString *)towRight {
    NSLog(@"oneLeft-%@ oneRight-%@ towLeft-%@ towRight-%@",oneLeft,oneRight,towLeft,towRight);

    for(int i=0; i<_hours_Arr.count; i++ )
        
        if( [oneLeft isEqual: _hours_Arr[i]]){
            
            left0_row=i;
            
        }else if ([towLeft isEqual:_hours_Arr[i]]){
            
            right0_row=i;
            
        }
    
    for (int j=0; j<_min_arr.count; j++) {
        
        if( [oneRight isEqual: _min_arr[j]]){
            
            left1_row=j;
            
        }else if ([towRight isEqual:_min_arr[j]]){
            
            right1_row=j;
            
        }
    }
    [_pickerView_left selectRow:left0_row inComponent:0 animated:true];
    
    [_pickerView_left selectRow:left1_row inComponent:1 animated:true];
    
    [_pickerView_right selectRow:right0_row inComponent:0 animated:YES];
    
    [_pickerView_right selectRow:right1_row inComponent:1 animated:YES];
}
#pragma mark ========================================pikerViewdelegate====================
//一共多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
//每列对应多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _hours_Arr.count;
    } else if (component == 1) {
        return _min_arr.count;
    }else
    {
        return  0;
    }
    
    //    else {
    //        return self.townArray.count;
    //    }
}
//每列每行显示的数据是什么
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [_hours_Arr objectAtIndex:row];
    } else if (component == 1) {
        return [_min_arr objectAtIndex:row];
    }else{
        
        return 0;
    }
    
}
////组建的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 50*self6WidthRate;
    } else if (component == 1) {
        return 50*self6WidthRate;
    }else{
        
        return 0;
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView==_pickerView_left) {
        
        if (component==0) {
            
            left0_row=row;
            
            [_pickerView_left reloadComponent:0];
            
        }else{
            
            left1_row=row;
            
            [_pickerView_left reloadComponent:1];
            
        }
        
    } else if (pickerView==_pickerView_right){
        
        if (component==0) {
            
            right0_row=row;
            
            [_pickerView_right reloadComponent:0];
            
        }else{
            
            right1_row=row;
            
            [_pickerView_right reloadComponent:1];
            
        }
        
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumScaleFactor = 8;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        
        pickerView.layer.borderWidth=0.5;
        
        pickerLabel.tag=row;
        
        pickerView.layer.borderColor=selfBacground.CGColor;
        
        [pickerLabel setFont:[UIFont systemFontOfSize:15]];
        
        if (_pickerView_left==pickerView) {
            
            if (component==0&&left0_row==row) {
                
                pickerLabel.textColor=selfGreen;
                
            }else if (component==1&&left1_row==row){
                
                pickerLabel.textColor=selfGreen;
                
            }
            
        }else if (_pickerView_right==pickerView){
            
            if (component==0&&right0_row==row) {
                
                pickerLabel.textColor=[UIColor redColor];
                
            }else if (component==1&&right1_row==row){
                
                pickerLabel.textColor=[UIColor redColor];
                
            }
        }
        
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}



@end
