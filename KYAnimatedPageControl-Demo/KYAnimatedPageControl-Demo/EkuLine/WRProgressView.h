//
//  WRProgressView.h
//  EkuKangDA
//
//  Created by ysghome on 5/20/16.
//  Copyright © 2016 eku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EkuLine.h"
/**
 *  候诊室进度条
 */
@interface WRProgressView : UIView

// page的个数
@property(nonatomic, assign) NSInteger pageCount;
/**
 *  未选中的颜色
 *  默认： [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00]
 */
@property(nonatomic, strong) UIColor *unSelectedColor;

/**
 *  选中的颜色
 *  默认： [UIColor colorWithRed:0.98 green:0.42 blue:0.46 alpha:1.00]
 */
@property(nonatomic, strong) UIColor *selectedColor;

/**
 *  进度
 */
@property (nonatomic) CGFloat progress;

/**
 *  设置进度条
 *
 *  @param progress 进度
 *  @param animated 是否动画
 */
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
