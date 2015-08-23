//
//  DVIBaseRefreshView.m
//  DVIRefresh
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 戴维营教育. All rights reserved.
//

#import "DVIBaseRefreshView.h"

#import "UIView+DVIUtils.h"
#import "UIScrollView+DVIRefresh.h"
#import "DVIRuntime.h"

#import <objc/message.h>

NSString * const DVIRefreshKeyPathContentOffset = @"contentOffset";
NSString * const DVIRefreshKeyPathContentSize = @"contentSize";

const CGFloat DVIRefreshVerticalHeightDefault = 50.0;
const CGFloat DVIRefreshHorizontalWidthDefault = 50.0;

@implementation DVIBaseRefreshView
#pragma mark - 创建方法
+ (instancetype)refreshViewWithPosition:(DVIRefreshPosition)position direction:(DVIRefreshDirection)direction block:(DVIRefreshTriggeredBlock)block{
    
    DVIBaseRefreshView *refreshView = [[self class] new];
    [refreshView setupRefreshView:position direction:direction];
    refreshView.triggeredBlock = block;
    
    return refreshView;
}

+ (instancetype)refreshViewWithPosition:(DVIRefreshPosition)position direction:(DVIRefreshDirection)direction target:(id)target action:(SEL)action {

    DVIBaseRefreshView *refreshView = [[self class] new];
    [refreshView setupRefreshView:position direction:direction];
    refreshView.target = target;
    refreshView.action = action;
    
    return refreshView;
}

+ (instancetype)refreshViewWithPosition:(DVIRefreshPosition)position direction:(DVIRefreshDirection)direction delegate:(id<DVIRefreshDelegate>)delegate {
    
    DVIBaseRefreshView *refreshView = [[self class] new];
    [refreshView setupRefreshView:position direction:direction];
    refreshView.delegate = delegate;
    
    return refreshView;
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _state = DVIRefreshStateStopped;
    }
    
    return self;
}

- (void)setupRefreshView:(DVIRefreshPosition)position direction:(DVIRefreshDirection)direction {
    _position = position;
    _direction = direction;
}

/*使用KVO获取UIScrollView的滑动事件*/
- (void)addObservers {
    DVIAddObserver(_scrollView, self, DVIRefreshKeyPathContentOffset);
    DVIAddObserver(_scrollView, self, DVIRefreshKeyPathContentSize);
}

- (void)removeObservers {
    DVIRemoveObserver(self.superview, self, DVIRefreshKeyPathContentOffset);
    DVIRemoveObserver(self.superview, self, DVIRefreshKeyPathContentSize);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:DVIRefreshKeyPathContentOffset]) {
        [self scrollViewDidScroll:_scrollView];
    }
    else if ([keyPath isEqualToString:DVIRefreshKeyPathContentSize]) {
        [self scrollViewDidChangedContentSize:_scrollView];
    }
}

/*视图添加事件*/
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    /*从UIScrollView上移除*/
    if (newSuperview == nil) {
        [self removeObservers];
        return;
    }
    
    /*只能添加到UIScrollView或其派生类上*/
    if (newSuperview && [newSuperview isKindOfClass:[UIScrollView class]]) {
        [self removeObservers];
        
        _scrollView = (UIScrollView *)newSuperview;
        
        [self placeRefreshView];
        [self addObservers];
    }
}

- (CGFloat)refreshViewOffset {
    CGFloat offset = 0.0;
    if (_direction == DVIRefreshDirectionVertical) {
        if (_position == DVIRefreshPositionHeader) {
            offset = -_scrollView.contentOffset.y;
        }
        else {
            offset = _scrollView.contentOffset.y + _scrollView.height - _scrollView.contentSize.height;
        }
    }
    else {
        if (_position == DVIRefreshPositionHeader) {
            offset = -_scrollView.contentOffset.x;
        }
        else {
            offset = _scrollView.contentOffset.x + _scrollView.width - _scrollView.contentSize.width;
        }
    }
    
    return offset;
}

/*计算百分比*/
- (void)updatePercent:(CGFloat)offset {
    if (offset > DVIRefreshVerticalHeightDefault) {
        _percent = 1.0;
    }
    else if (offset < 0) {
        _percent = 0.0;
    }
    else {
        _percent = offset / DVIRefreshVerticalHeightDefault;
    }
}

- (void)triggerAction {
    if (_triggeredBlock) {
        _triggeredBlock();
    }
    
    if ([_target respondsToSelector:_action]) {
        DVIMsgSend(_target, _action, self);
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didRefreshTriggered:)]) {
        [_delegate didRefreshTriggered:self];
    }
}

/*设置加载时所需要的停靠位置*/
- (void)setScrollViewContentInset:(UIEdgeInsets)contentInset {
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _scrollView.contentInset = contentInset;
                     }
                     completion:NULL];
}

- (void)setupContentInset {
    UIEdgeInsets contentInset = _scrollView.contentInset;
    
    if (_direction == DVIRefreshDirectionVertical) {
        if (_position == DVIRefreshPositionHeader) {
            contentInset.top = DVIRefreshVerticalHeightDefault;
        }
        else {
            contentInset.bottom = DVIRefreshVerticalHeightDefault;
        }
    }
    else {
        if (_position == DVIRefreshPositionHeader) {
            contentInset.left = DVIRefreshHorizontalWidthDefault;
        }
        else {
            contentInset.right = DVIRefreshHorizontalWidthDefault;
        }
    }
    
    [self setScrollViewContentInset:contentInset];
}

- (void)resetContentInset {
    UIEdgeInsets contentInset = _scrollView.contentInset;
    
    if (_direction == DVIRefreshDirectionVertical) {
        if (_position == DVIRefreshPositionHeader) {
            contentInset.top = 0.0;
        }
        else {
            contentInset.bottom = 0.0;
        }
    }
    else {
        if (_position == DVIRefreshPositionHeader) {
            contentInset.left = 0.0;
        }
        else {
            contentInset.right = 0.0;
        }
    }
    
    [self setScrollViewContentInset:contentInset];
}

- (void)update {
    [self doesNotRecognizeSelector:_cmd];
}

/*UIScrollView滚动*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = [self refreshViewOffset];
    if (offset < 0) {
        return;
    }
    
    [self updatePercent:offset];
    
    if (_state != DVIRefreshStateTriggered) {
        if (scrollView.isDragging && offset > 0) {
            if (offset >= DVIRefreshVerticalHeightDefault) {
                _state = DVIRefreshStateWillTriggered;
            }
            else {
                _state = DVIRefreshStatePulling;
            }
        }
        else {
            if (!scrollView.isLoading && offset >= DVIRefreshVerticalHeightDefault) {
                _state = DVIRefreshStateTriggered;
                [self triggerAction];
            }
            else {
                _state = DVIRefreshStateStopped;
            }
        }
    }
    else {
        [self setupContentInset];
    }
    
    [self update];
}

/*UIScrollView的contentSize改变*/
- (void)scrollViewDidChangedContentSize:(UIScrollView *)scrollView {
    [self placeRefreshView];
}

/*根据方向和位置布局刷新视图*/
- (void)placeRefreshView {
    if (_direction == DVIRefreshDirectionVertical) {
        if (_position == DVIRefreshPositionHeader) {
            self.frame = CGRectMake(0, -DVIRefreshVerticalHeightDefault, _scrollView.width, DVIRefreshVerticalHeightDefault);
        }
        else {
            self.frame = CGRectMake(0, _scrollView.contentSize.height, _scrollView.width, DVIRefreshVerticalHeightDefault);
        }
    }
    else {
        if (_position == DVIRefreshPositionHeader) {
            self.frame = CGRectMake(-DVIRefreshHorizontalWidthDefault, 0, DVIRefreshHorizontalWidthDefault, _scrollView.height);
        }
        else {
            self.frame = CGRectMake(_scrollView.contentSize.width, 0, DVIRefreshHorizontalWidthDefault, _scrollView.height);
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

#pragma mark - 手动加载方式
- (void)beginRefresh {
	
}

- (void)endRefresh {
    _state = DVIRefreshStateStopped;
    [self resetContentInset];
}

- (BOOL)isRefreshing {
    if (_state == DVIRefreshStateTriggered) {
        return YES;
    }
    
    return NO;
}

- (void)allLoaded {
    _state = DVIRefreshStateAllLoaded;
}

#pragma mark - 下一版本使用
- (void)didScroll {}
- (void)willTrigger {}
- (void)didTriggered {}
- (void)didEndScroll {}

- (void)dealloc {
//    NSLog(@"%s", __PRETTY_FUNCTION__);
}
@end
