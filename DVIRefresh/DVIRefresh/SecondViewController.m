//
//  SecondViewController.m
//  DVIRefresh
//
//  Created by apple on 15/8/19.
//  Copyright (c) 2015年 戴维营教育. All rights reserved.
//

#import "SecondViewController.h"
#import "DVISimpleRefreshView.h"
#import "UIScrollView+DVIRefresh.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SecondViewController
- (IBAction)didClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width, 1000);
    _scrollView.headerView = [DVISimpleRefreshView refreshViewWithPosition:DVIRefreshPositionHeader direction:DVIRefreshDirectionVertical block:^{
        NSLog(@"test");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
