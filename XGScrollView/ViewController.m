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
    
    //  使用 collectionView
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(800, 450);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    XGCollectionView * collectionView = [[XGCollectionView alloc] initWithFrame:CGRectMake(0, 0, 800, 450) collectionViewLayout:layout imageUrls:@[image_url1,image_url2,image_url3] placeHolder:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpeg"] duration:2.0f];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    self.view.backgroundColor = [UIColor whiteColor];
    collectionView.backgroundColor = [UIColor grayColor];
    
    //  使用 ScrollView
//    XGScrollView * scrollView = [[XGScrollView alloc] initWithFrame:CGRectMake(0, 0, 400, 300) Images:@[image_url1,image_url2,image_url3] placeHolder:image1 duration:1.0];
//    
//    [scrollView start];
//    
//    [self.view addSubview:scrollView];
//    
//    self.scrollView = scrollView;
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
    //  使用 ScrollView
//    if (self.scrollView.isRuning) {
//        [self.scrollView stop];
//    }else{
//        [self.scrollView start];
//    }
    
    
    if (self.collectionView.isRuning) {
        [self.collectionView stop];
    }else{
        [self.collectionView start];
    }
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
