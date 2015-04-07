//
//  HeaderRefreshView.h
//  newRefresh
//
//  Created by apple on 15/4/7.
//  Copyright (c) 2015年 com.eku001. All rights reserved.
//

#import "RefreshBaseView.h"

@protocol HearderRefreshDelegate <NSObject>
@optional
- (void)refreshViewStart;
@end
@interface HeaderRefreshView : RefreshBaseView

@property (nonatomic, assign) id<HearderRefreshDelegate> delegate;

@end
