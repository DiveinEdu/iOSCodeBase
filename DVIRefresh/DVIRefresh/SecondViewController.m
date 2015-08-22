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
    
//    __weak typeof(_scrollView) weakScroll = _scrollView;
//    _scrollView.headerView = [DVISimpleRefreshView refreshViewWithPosition:DVIRefreshPositionHeader direction:DVIRefreshDirectionVertical block:^{
//        NSLog(@"test");
//        [weakScroll.headerView endRefresh];
//    }];
    
    //有导航条的情况（iOS 7）
    self.navigationController.navigationBar.translucent = NO;
    
    __weak typeof(_scrollView) weakScrollView = _scrollView;
    DVISimpleRefreshView *refreshView = [DVISimpleRefreshView refreshViewWithPosition:DVIRefreshPositionHeader direction:DVIRefreshDirectionVertical block:^{

        [weakScrollView.headerView endRefresh];
    }];
    _scrollView.headerView = refreshView;
    
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [_scrollView.header endRefreshing];
//    }];
//    _scrollView.header = header;
    
    NSLog(@"1. %@", NSStringFromUIEdgeInsets(_scrollView.contentInset));
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"2. %@", NSStringFromUIEdgeInsets(_scrollView.contentInset));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"3. %@", NSStringFromUIEdgeInsets(_scrollView.contentInset));

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width, 1000);

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
