//
//  DVISimpleRefreshView.m
//  DVIRefresh
//
//  Created by apple on 15/8/2.
//  Copyright (c) 2015年 戴维营教育. All rights reserved.
//

#import "DVISimpleRefreshView.h"
#import "DVILog.h"
#import "UIView+DVIUtils.h"

@interface DVISimpleRefreshView ()
{
    UIActivityIndicatorView *_indicatorView;
}
@end

@implementation DVISimpleRefreshView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        [self addSubview:_imageView];
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.hidesWhenStopped = YES;
        [self addSubview:_indicatorView];
        
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.font = [UIFont systemFontOfSize:14];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.text = @"下拉刷新";
        [self addSubview:_stateLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.text = @"最近更新时间";
        [self addSubview:_timeLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_timeLabel.hidden) {
        _stateLabel.frame = self.bounds;
    }
    else {
        _stateLabel.frame = CGRectMake(0, 0, self.width, self.height * 0.5);
        _timeLabel.frame = CGRectMake(0, _stateLabel.height, self.width, self.height * 0.5);
    }
    
    _imageView.size = _imageView.image.size;
    _imageView.center = CGPointMake(self.width * 0.5 - 100, self.height * 0.5);
    
    _indicatorView.frame = _imageView.frame;
}

- (void)updateImageView {
    if (self.state == DVIRefreshStatePulling) {
        _imageView.hidden = NO;
        [_indicatorView stopAnimating];
        [UIView animateWithDuration:0.3 animations:^{
            _imageView.transform = CGAffineTransformIdentity;
        }];
    }
    else if (self.state == DVIRefreshStateWillTriggered) {
        [UIView animateWithDuration:0.3 animations:^{
            _imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }
    else if (self.state == DVIRefreshStateTriggered) {
        _imageView.hidden = YES;
        [_indicatorView startAnimating];
    }
}

- (void)update {
    switch (self.state) {
        case DVIRefreshStateStopped:
            _stateLabel.text = @"下拉刷新";
            break;
        case DVIRefreshStatePulling:
            _stateLabel.text = @"正在下拉";
            break;
        case DVIRefreshStateWillTriggered:
            _stateLabel.text = @"松开加载";
            break;
        case DVIRefreshStateTriggered:
            _stateLabel.text = @"正在努力的加载中";
            break;
        case DVIRefreshStateAllLoaded:
            _stateLabel.text = @"已经没有新数据";
            break;
        default:
            break;
    }
    
    [self updateImageView];
    
    DVILog(@"%@", _stateLabel.text);
}

//- (void)endRefresh {
//    [super endRefresh];
//    
//    _imageView.hidden = NO;
//    [UIView animateWithDuration:0.3 animations:^{
//        _imageView.transform = CGAffineTransformIdentity;
//    }];
//    
//    [_indicatorView stopAnimating];
//}
@end
