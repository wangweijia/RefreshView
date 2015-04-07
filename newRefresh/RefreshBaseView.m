//
//  RefreshBaseView.m
//  newRefresh
//
//  Created by apple on 15/3/30.
//  Copyright (c) 2015年 com.eku001. All rights reserved.
//

#import "RefreshBaseView.h"

@interface RefreshBaseView()

@end

@implementation RefreshBaseView

- (instancetype)init{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *titLabel = [[UILabel alloc] init];
        titLabel.text = @"正在加载数据..";
        _titleLable = titLabel;
        [self addSubview:titLabel];
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        [self setActivityIndicatorView:activityView];
        [self addSubview:activityView];
    }
    return self;
}

- (void)setBaseTableView:(UITableView *)baseTableView{
    // 移除之前的监听器
    [_baseTableView removeObserver:self forKeyPath:@"contentOffset" context:nil];
    
    [_baseTableView removeObserver:self forKeyPath:@"contentSize" context:nil];
    
    // 监听contentOffset
    [baseTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    [baseTableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];

    _baseTableView = baseTableView;

}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat titLabelw = [_titleLable.text sizeWithFont:_titleLable.font].width;
    CGFloat titLabelH = [_titleLable.text sizeWithFont:_titleLable.font].height;
    CGFloat titLabelX = (REFRESHVIEW_WITH - titLabelw) / 2;
    CGFloat titLabelY = (REFRESHVIEW_HEIGHT - titLabelH) / 2;
    [_titleLable setFrame:CGRectMake(titLabelX, titLabelY, titLabelw, titLabelH)];
    
    CGFloat activityViewW = 20.0;
    CGFloat activityViewH = 20.0;
    CGFloat activityViewX = CGRectGetMinX(_titleLable.frame) - activityViewW - 10;
    CGFloat activityViewY = (REFRESHVIEW_HEIGHT - activityViewH) / 2;
    [_activityIndicatorView setFrame:CGRectMake(activityViewX, activityViewY, activityViewW, activityViewH)];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self setNeedsLayout];
    }
    
    if ([keyPath isEqualToString:@"contentOffset"] && _baseTableView.isDragging) {
        if ( _refreshViewStats == RefreshStateNormal) {
            if (_refreshViewType == RefreshViewTypeFooter) {
                //上拉刷新
                CGFloat ySet = _baseTableView.contentSize.height - _baseTableView.frame.size.height;
                if (ySet < 0)
                    ySet = 0;
                [self pull_up:_baseTableView.contentOffset.y - ySet];
            }else{
                //下拉刷新
                [self pull_down:_baseTableView.contentOffset.y];
            }
        }
    }
}

-(void)setFrame:(CGRect)frame{
    CGRect aFrame = CGRectMake(0, frame.origin.y, REFRESHVIEW_WITH, REFRESHVIEW_HEIGHT);
    [super setFrame:aFrame];
}

//结束刷新
- (void)stopRefresh{}

//上拉刷新
- (void)pull_up:(CGFloat)set{}

//下拉刷新
- (void)pull_down:(CGFloat)set{}

@end
