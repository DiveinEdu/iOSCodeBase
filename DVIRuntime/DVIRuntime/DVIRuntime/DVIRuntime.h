//
//  DVIRuntime.h
//  DVIRuntime
//
//  Created by apple on 15/8/2.
//  Copyright (c) 2015年 戴维营教育. All rights reserved.
//

#ifndef DVIRuntime_DVIRuntime_h
#define DVIRuntime_DVIRuntime_h

#import <Foundation/Foundation.h>
#import <objc/message.h>

#define DVIMsgSend(target, action, ...) ((void(*)(id, SEL, ...))objc_msgSend)(target, action, ## __VA_ARGS__)

#endif
