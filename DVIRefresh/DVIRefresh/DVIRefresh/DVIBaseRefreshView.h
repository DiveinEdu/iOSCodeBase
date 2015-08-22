//
//  DVIBaseRefreshView.h
//  DVIRefresh
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 戴维营教育. All rights reserved.
//

#import <UIKit/UIKit.h>

/*更新状态*/
typedef enum : NSUInteger {
    DVIRefreshStateStopped,         //静止状态
    DVIRefreshStatePulling,         //拖动状态
    DVIRefreshStateWillTriggered,   //即将刷新（到达阈值）
    DVIRefreshStateTriggered,       //触发状态
    DVIRefreshStateAllLoaded,       //全部数据被加载，用于上拉加载
} DVIRefreshState;

/*支持刷新和加载更多*/
typedef enum : NSUInteger {
    DVIRefreshPositionHeader,   //头部
    DVIRefreshPositionFooter,   //尾部
} DVIRefreshPosition;

/*期待支持水平滚动*/
typedef enum : NSUInteger {
    DVIRefreshDirectionHorizontal,  //水平
    DVIRefreshDirectionVertical,    //垂直
} DVIRefreshDirection;

UIKIT_EXTERN NSString * const DVIRefreshKeyPathContentOffset;
UIKIT_EXTERN NSString * const DVIRefreshKeyPathContentSize;

UIKIT_EXTERN const CGFloat DVIRefreshVerticalHeightDefault;
UIKIT_EXTERN const CGFloat DVIRefreshHorizontalWidthDefault;

/*触发刷新或加载事件*/
typedef void(^DVIRefreshTriggeredBlock)();

/*添加KVO观察者*/
#define DVIAddObserver(object, target, keyPath) [object addObserver:target forKeyPath:keyPath options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL]

/*移除KVO观察者*/
#define DVIRemoveObserver(object, target, keyPath) [object removeObserver:target forKeyPath:keyPath]

@class DVIBaseRefreshView;

#pragma mark - DVIRefreshDelegate
@protocol DVIRefreshDelegate <NSObject>

@optional
- (void)didRefreshTriggered:(DVIBaseRefreshView *)refreshView;

@end

@interface DVIBaseRefreshView : UIView
{

}

@property (nonatomic, assign, readonly) DVIRefreshState state;
@property (nonatomic, assign, readonly) DVIRefreshPosition position;
@property (nonatomic, assign, readonly) DVIRefreshDirection direction;

///*触发刷新所需要的最小偏移量，默认为headerView的高度或者footerView的宽度*/
//@property (nonatomic, assign) CGFloat refreshSize;

@property (nonatomic, weak) UIScrollView *scrollView;

/*更新时间*/
@property (nonatomic, copy, readonly) NSString *lastUpdateTime;

/*达到触发状态的百分比，用于简化透明度变化等动画*/
@property (nonatomic, assign, readonly) CGFloat percent;

/*使用Block触发刷新或加载*/
@property (nonatomic, copy) DVIRefreshTriggeredBlock triggeredBlock;

/*使用Target－Action触发刷新或加载*/
@property (nonatomic, weak)     id target;
@property (nonatomic, assign)   SEL action;

/*使用代理出发刷新或加载*/
@property (nonatomic, weak) id<DVIRefreshDelegate> delegate;

/*创建刷新视图多种方式*/
/*1. Block方式*/
+ (instancetype)refreshViewWithPosition:(DVIRefreshPosition)position direction:(DVIRefreshDirection)direction block:(DVIRefreshTriggeredBlock)block;

/*2. Target-Action方式*/
+ (instancetype)refreshViewWithPosition:(DVIRefreshPosition)position direction:(DVIRefreshDirection)direction target:(id)target action:(SEL)action;

/*3. 代理方式*/
+ (instancetype)refreshViewWithPosition:(DVIRefreshPosition)position direction:(DVIRefreshDirection)direction delegate:(id<DVIRefreshDelegate>)delegate;

/*UIScrollView动作*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidChangedContentSize:(UIScrollView *)scrollView;

/*自定义刷新控件时必须要Override的方法，可以在里面根据控件的状态显示信息*/
- (void)update;

/*手动操作刷新开始和结束*/
- (void)beginRefresh;
- (void)endRefresh;
- (BOOL)isRefreshing;

- (void)allLoaded;

/*用来覆盖的时机，暂未实现，下一版本使用*/
- (void)didScroll;
- (void)willTrigger;
- (void)didTriggered;
- (void)didEndScroll;
@end
