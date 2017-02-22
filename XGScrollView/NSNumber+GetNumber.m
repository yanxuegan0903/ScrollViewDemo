//
//  NSNumber+GetNumber.m
//  UUSmartHome
//
//  Created by vsKing on 2016/10/14.
//  Copyright © 2016年 Fuego. All rights reserved.
//

#import "NSNumber+GetNumber.h"
#import "AppDelegate.h"


@implementation NSNumber (GetNumber)

+ (double)getTransNumberCompareWidth:(double)num
{
    double width = [UIScreen mainScreen].bounds.size.width;
    double height = [UIScreen mainScreen].bounds.size.height;
    width = width<height?width:height;
    double multi = width/1080;
    num = num * multi;
    
    return num;
}


+ (double)getTransNumberCompareHeight:(double)num
{
    double height = [UIScreen mainScreen].bounds.size.height;
    double width = [UIScreen mainScreen].bounds.size.width;
    
    height = height > width?height:width;
    
    double multi = height/1920;
    num = num * multi;
    
    return num;
}

@end
