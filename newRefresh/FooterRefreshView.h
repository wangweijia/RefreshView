//
//  FooterRefreshView.h
//  newRefresh
//
//  Created by apple on 15/3/30.
//  Copyright (c) 2015年 com.eku001. All rights reserved.
//

#import "RefreshBaseView.h"

@protocol FooterRefreshViewDelegate <NSObject>
@optional
- (void)refreshViewStart:(RefreshViewType)refreshViewType;
@end

@interface FooterRefreshView : RefreshBaseView

@property (nonatomic, assign) id<FooterRefreshViewDelegate> delegate;

@end