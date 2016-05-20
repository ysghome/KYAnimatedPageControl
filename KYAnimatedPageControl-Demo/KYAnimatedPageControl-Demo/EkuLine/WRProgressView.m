//
//  WRProgressView.m
//  EkuKangDA
//
//  Created by ysghome on 5/20/16.
//  Copyright © 2016 eku. All rights reserved.
//

#import "WRProgressView.h"

@interface WRProgressView ()

@property (nonatomic, strong) EkuLine *line;

@end

@implementation WRProgressView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self.layer addSublayer:self.line];
    [self.line setNeedsDisplay];
}

- (EkuLine *)line {
    if (!_line) {
        _line = [EkuLine layer];
        _line.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _line.pageCount = self.pageCount;
        _line.selectedPage = 1;
        _line.unSelectedColor = self.unSelectedColor;
        _line.selectedColor = self.selectedColor;
        _line.contentsScale = [UIScreen mainScreen].scale;
    }
    
    return _line;
}

- (UIColor *)unSelectedColor {
    if (!_unSelectedColor) {
        return [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00];
    }
    return _unSelectedColor;
}

- (UIColor *)selectedColor {
    if (!_selectedColor) {
        return [UIColor colorWithRed:0.98 green:0.42 blue:0.46 alpha:1.00];
    }
    return _selectedColor;
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    CGFloat pinnedProgress = MIN(MAX(progress, 0.0f), 1.0f);
    [self.line setProgress:pinnedProgress animated:YES];
}


@end
