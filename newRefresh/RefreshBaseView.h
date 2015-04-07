//
//  RefreshBaseView.h
//  newRefresh
//
//  Created by apple on 15/3/30.
//  Copyright (c) 2015年 com.eku001. All rights reserved.
//

#import <UIKit/UIKit.h>

#define REFRESHVIEW_WITH [[UIScreen mainScreen] bounds].size.width
#define REFRESHVIEW_HEIGHT 44

// 控件的刷新状态
typedef NS_ENUM(NSInteger, RefreshState){
    RefreshStateNormal = 1, // 普通状态
    RefreshStateLoading = 2, // 正在刷新中的状态
};

// 控件的类型
typedef NS_ENUM(NSInteger, RefreshViewType) {
    RefreshViewTypeHeader = -1, // 头部控件
    RefreshViewTypeFooter = 1 // 尾部控件
};

@interface RefreshBaseView : UIView

//提示文字
@property (nonatomic, weak) UILabel *titleLable;
//转到加载控件
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicatorView;
//所处tableview
@property (nonatomic, weak) UIScrollView *baseTableView;
//控件 具体 样式
@property (nonatomic, assign) RefreshViewType refreshViewType;
//控件所处状态
@property (nonatomic, assign) RefreshState refreshViewStats;

//结束刷新
- (void)stopRefresh;
//上拉刷新
- (void)pull_up:(CGFloat)set;
//下拉刷新
- (void)pull_down:(CGFloat)set;

@end
