//
//  HeaderRefreshView.m
//  newRefresh
//
//  Created by apple on 15/4/7.
//  Copyright (c) 2015年 com.eku001. All rights reserved.
//

#import "HeaderRefreshView.h"

@interface HeaderRefreshView()

@property (nonatomic, assign) CGFloat top;

@end

@implementation HeaderRefreshView

- (instancetype)init{
    if (self = [super init]) {
        [self setRefreshViewType:RefreshViewTypeHeader];
        [self setRefreshViewStats:RefreshStateNormal];
    }
    return self;
}

- (void)setRefreshViewStats:(RefreshState)refreshViewStats
{
    [super setRefreshViewStats:refreshViewStats];
    
    switch (refreshViewStats) {
        case RefreshStateNormal: {
            [self.activityIndicatorView stopAnimating];
            [self.titleLable setText:@"下拉加载"];
            [self removeFromSuperview];
        }
            break;
        case RefreshStateLoading: {
            [self.activityIndicatorView startAnimating];
            [self.titleLable setText:@"正在加载"];
            
            if ([self.delegate respondsToSelector:@selector(refreshViewStart)]) {
                [self.delegate refreshViewStart];
            }
            
            [self setFrame:CGRectMake(0, -44, 0, 0)];
            [self.baseTableView addSubview:self];
        }
            break;
        default:
            break;
    }
}

- (void)pull_down:(CGFloat)set{
    if (set < 0) {
        NSLog(@"下拉开始刷新");
        [self setRefreshViewStats:RefreshStateLoading];
        
        self.top = 44;
        [UIView animateWithDuration:0.3 animations:^{
            UIEdgeInsets inset = self.baseTableView.contentInset;
            inset.top = self.baseTableView.contentInset.top + _top;
            self.baseTableView.contentInset = inset;
        }];
    }
}

- (void)stopRefresh{
    NSLog(@"下拉刷新结束");
    [self setRefreshViewStats:RefreshStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets inset = self.baseTableView.contentInset;
        inset.top = self.baseTableView.contentInset.top - _top;
        self.baseTableView.contentInset = inset;
    }];
}


@end
