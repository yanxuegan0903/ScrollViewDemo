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

@property (nonatomic, strong) XGScrollView *scrollView;
@property (nonatomic, strong) XGCollectionView *collectionView;


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
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(800, 450);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    XGCollectionView * collectionView = [[XGCollectionView alloc] initWithFrame:CGRectMake(0, 0, 800, 450) collectionViewLayout:layout imageUrls:@[image_url1,image_url2,image_url3]];
    [self.view addSubview:collectionView];
    
    
    
//    XGScrollView * scrollView = [[XGScrollView alloc] initWithFrame:CGRectMake(0, 0, 400, 300) Images:@[image_url1,image_url2,image_url3] placeHolder:image1 duration:1.0];
//    
//    [scrollView start];
//    
//    [self.view addSubview:scrollView];
//    
//    self.scrollView = scrollView;
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
    if (self.scrollView.isRuning) {
        [self.scrollView stop];
    }else{
        [self.scrollView start];
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
