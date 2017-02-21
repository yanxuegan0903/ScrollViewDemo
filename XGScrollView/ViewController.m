//
//  ViewController.m
//  XGScrollView
//
//  Created by vsKing on 2017/2/21.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "ViewController.h"
#import "XGScrollView.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *image_url1 = @"http://s1.uuioe.net:4888/75e977fdcc04ed878de7e015658bcdfe";
    NSString *image_url2 = @"http://s1.uuioe.net:4888/b633a05628f2f4560f95dba9b828db54";
    NSString *image_url3 = @"http://s1.uuioe.net:4888/a05c8d2ff7acd05715b913010c6babec";
    
    
    UIImage * image1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1.jpeg" ofType:nil]];

    
    if (!image1) {
        NSLog(@"文件不存在");
        return;
    }
    
    
    
    XGScrollView * scrollView = [[XGScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) Images:@[image_url1,image_url2,image_url3] placeHolder:image1 duration:0.5];
    [self.view addSubview:scrollView];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
