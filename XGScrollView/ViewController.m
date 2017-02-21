//
//  ViewController.m
//  XGScrollView
//
//  Created by vsKing on 2017/2/21.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "ViewController.h"
#import "XGScrollView.h"
#import "XGCollectionView.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIImage * image1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1.jpeg" ofType:nil]];
    UIImage * image2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"2.jpeg" ofType:nil]];
    UIImage * image3 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"3.jpeg" ofType:nil]];
    
    if (!image1) {
        NSLog(@"文件不存在");
        return;
    }
    
    
//    XGCollectionView * collectionView = [[XGCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) dataSource:@[image1,image2,image3]];
//    [self.view addSubview:collectionView];
    
    
    
    
    XGScrollView * scrollView = [[XGScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) images:@[image1,image2,image3]];
    
    [self.view addSubview:scrollView];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
