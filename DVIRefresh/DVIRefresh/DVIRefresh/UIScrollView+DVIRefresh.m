//
//  UIScrollView+DVIRefresh.m
//  DVIRefresh
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 戴维营教育. All rights reserved.
//

#import "UIScrollView+DVIRefresh.h"
#import <objc/runtime.h>

const char * const DVIRefreshHeaderViewKey = "DVIRefreshHeaderView";
const char * const DVIRefreshFooterViewKey = "DVIRefreshFooterView";

@implementation UIScrollView (DVIRefresh)
#pragma mark - HeaderView
- (void)setHeaderView:(DVIBaseRefreshView *)headerView {
    if (self.headerView != headerView) {
        [self.headerView removeFromSuperview];
        [self addSubview:headerView];
        
        [self willChangeValueForKey:@"headerView"];
        objc_setAssociatedObject(self, DVIRefreshHeaderViewKey, headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"headerView"];
    }
}

- (DVIBaseRefreshView *)headerView {
    return objc_getAssociatedObject(self, DVIRefreshHeaderViewKey);
}

#pragma mark - FooterView
- (void)setFooterView:(DVIBaseRefreshView *)footerView {
    if (self.footerView != footerView) {
        [self.footerView removeFromSuperview];
        [self addSubview:footerView];
        
        [self willChangeValueForKey:@"footerView"];
        objc_setAssociatedObject(self, DVIRefreshFooterViewKey, footerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"footerView"];
    }
}

- (DVIBaseRefreshView *)footerView {
    return objc_getAssociatedObject(self, DVIRefreshFooterViewKey);
}

- (BOOL)isLoading {
    return self.headerView.isRefreshing || self.footerView.isRefreshing;
}

- (void)endRefresh {
    if (self.headerView.isRefreshing) {
        [self.headerView endRefresh];
    }
    else if (self.footerView.isRefreshing) {
        [self.footerView endRefresh];
    }
}
@end
