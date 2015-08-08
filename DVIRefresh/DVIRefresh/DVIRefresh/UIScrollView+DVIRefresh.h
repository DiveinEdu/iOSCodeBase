//
//  UIScrollView+DVIRefresh.h
//  DVIRefresh
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 戴维营教育. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DVIBaseRefreshView.h"

@interface UIScrollView (DVIRefresh)
@property (nonatomic, strong) DVIBaseRefreshView *headerView;
@property (nonatomic, strong) DVIBaseRefreshView *footerView;

@property (nonatomic, assign, readonly, getter=isLoading) BOOL loading;

- (void)endRefresh;
@end
