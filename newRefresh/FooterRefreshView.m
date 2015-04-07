//
//  FooterRefreshView.m
//  newRefresh
//
//  Created by apple on 15/3/30.
//  Copyright (c) 2015年 com.eku001. All rights reserved.
//

#import "FooterRefreshView.h"

@interface FooterRefreshView()

@property (nonatomic, assign) CGFloat bottom;

@end

@implementation FooterRefreshView

- (instancetype)init{
    if (self = [super init]) {
        [self setRefreshViewType:RefreshViewTypeFooter];
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
            [self.titleLable setText:@"上拉加载"];
            [self removeFromSuperview];
        }
            break;
        case RefreshStateLoading: {
            [self.activityIndicatorView startAnimating];
            [self.titleLable setText:@"正在加载"];
            
            if ([self.delegate respondsToSelector:@selector(refreshViewStart)]) {
                [self.delegate refreshViewStart];
            }
            
            [self setFrame:CGRectMake(0, MAX(self.baseTableView.contentSize.height,self.baseTableView.frame.size.height), 0, 0)];
            [self.baseTableView addSubview:self];
        }
            break;
        default:
            break;
    }
}

- (void)pull_up:(CGFloat)set{
    if (set >= 0) {
        NSLog(@"上拉开始刷新");
        [self setRefreshViewStats:RefreshStateLoading];

        if (self.baseTableView.contentSize.height >= self.baseTableView.frame.size.height) {
            _bottom = 44;
        }else{
            _bottom = self.baseTableView.frame.size.height - self.baseTableView.contentSize.height + 44;
        }
        [UIView animateWithDuration:0.3 animations:^{
            UIEdgeInsets inset = self.baseTableView.contentInset;
            inset.bottom = self.baseTableView.contentInset.bottom + _bottom;
            self.baseTableView.contentInset = inset;
        }];
    }
}

- (void)stopRefresh{
    NSLog(@"上拉刷新结束");
    [self setRefreshViewStats:RefreshStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets inset = self.baseTableView.contentInset;
        inset.bottom = self.baseTableView.contentInset.bottom - _bottom;
        self.baseTableView.contentInset = inset;
    }];
}

@end