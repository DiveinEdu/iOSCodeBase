//
//  ViewController.m
//  DVILog
//
//  Created by apple on 15/8/8.
//  Copyright (c) 2015年 戴维营教育. All rights reserved.
//

#import "ViewController.h"

#import "DVILog.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DVILog(@"Hello: %@", @"戴维营教育");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
