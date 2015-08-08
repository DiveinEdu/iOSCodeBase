//
//  DVISimpleRefreshView.h
//  DVIRefresh
//
//  Created by apple on 15/8/2.
//  Copyright (c) 2015年 戴维营教育. All rights reserved.
//

#import "DVIBaseRefreshView.h"

@interface DVISimpleRefreshView : DVIBaseRefreshView

@property (nonatomic, strong, readonly) UIImageView  *imageView;
@property (nonatomic, strong, readonly) UILabel *stateLabel;
@property (nonatomic, strong, readonly) UILabel *timeLabel;
@end
