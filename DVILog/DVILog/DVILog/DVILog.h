//
//  DVILog.h
//  DVILog
//
//  Created by apple on 15/8/8.
//  Copyright (c) 2015年 戴维营教育. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
    #define DVILog(fmt,...) NSLog(@"(%s:%d) " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
    #define DVILog(fmt,...)
#endif