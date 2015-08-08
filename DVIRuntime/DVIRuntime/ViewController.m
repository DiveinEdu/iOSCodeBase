//
//  ViewController.m
//  DVIRuntime
//
//  Created by apple on 15/8/2.
//  Copyright (c) 2015年 戴维营教育. All rights reserved.
//

#import "ViewController.h"

#import "DVIRuntime.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    DVIMsgSend(self, @selector(print));
}

- (void)print {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
