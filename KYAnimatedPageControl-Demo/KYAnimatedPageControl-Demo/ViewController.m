//
//  ViewController.m
//  KYAnimatedPageControl-Demo
//
//  Created by Kitten Yang on 6/9/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "ViewController.h"
#import "KYAnimatedPageControl.h"
#import "DemoCell.h"
#import "WRProgressView.h"


@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic, strong) KYAnimatedPageControl *pageControl;
@property(weak, nonatomic) IBOutlet UICollectionView *demoCollectionView;

@property (nonatomic, strong) WRProgressView *wrProgressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageControl = [[KYAnimatedPageControl alloc]
                        initWithFrame:CGRectMake(20, 450, 280, 30)];
    [self.pageControl setBackgroundColor:[UIColor grayColor]];
    self.pageControl.pageCount = 8;
    self.pageControl.unSelectedColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00];
    self.pageControl.selectedColor = [UIColor colorWithRed:0.98 green:0.42 blue:0.46 alpha:1.00];
//    self.pageControl.bindScrollView = self.demoCollectionView;
    self.pageControl.shouldShowProgressLine = YES;
    self.pageControl.indicatorStyle = IndicatorStyleGooeyCircle;
    self.pageControl.indicatorSize = 0;
    self.pageControl.swipeEnable = YES;
    [self.view addSubview:self.pageControl];
    
    self.pageControl.didSelectIndexBlock = ^(NSInteger index) {
        NSLog(@"Did Selected index : %ld", (long)index);
    };
    
    self.wrProgressView = [[WRProgressView alloc] initWithFrame:CGRectMake(20, 480, 280, 30)];
    [self.wrProgressView setBackgroundColor:[UIColor blackColor]];
     self.wrProgressView.pageCount = 7;
    [self.view addSubview:self.wrProgressView];
    
}

- (IBAction)changeProgressViewV:(UISlider *)sender {
    [self.wrProgressView setProgress:sender.value animated:NO];
}


#pragma mark-- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.pageControl.pageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DemoCell *democell = (DemoCell *)[collectionView
                                      dequeueReusableCellWithReuseIdentifier:@"democell"
                                      forIndexPath:indexPath];
    democell.cellNumLabel.text =
    [NSString stringWithFormat:@"%ld", indexPath.item + 1];
    
    return democell;
}

#pragma mark-- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Indicator动画
    [self.pageControl.indicator animateIndicatorWithScrollView:scrollView
                                                  andIndicator:self.pageControl];
    
    if (scrollView.dragging || scrollView.isDecelerating || scrollView.tracking) {
        //背景线条动画
        [self.pageControl.pageControlLine
         animateSelectedLineWithScrollView:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.indicator.lastContentOffset = scrollView.contentOffset.x;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [self.pageControl.indicator
     restoreAnimation:@(1.0 / self.pageControl.pageCount)];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.pageControl.indicator.lastContentOffset = scrollView.contentOffset.x;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action

- (IBAction)animateToForthPage:(id)sender {
    [self.pageControl animateToIndex:3];
}

- (IBAction)swipeEnableChanged:(UISwitch *)sender {
    self.pageControl.swipeEnable = sender.isOn;
}

@end
