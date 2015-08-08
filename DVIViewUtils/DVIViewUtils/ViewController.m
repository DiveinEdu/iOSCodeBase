//
//  ViewController.m
//  DVIViewUtils
//
//  Created by apple on 15/8/2.
//  Copyright (c) 2015年 戴维营教育. All rights reserved.
//

#import "ViewController.h"

#import "UIView+DVIUtils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *v = [UIView new];
    v.backgroundColor = [UIColor redColor];
    v.x = 100;
    v.y = 200;
    v.width = 100;
    v.height = 200;
    [self.view addSubview:v];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
