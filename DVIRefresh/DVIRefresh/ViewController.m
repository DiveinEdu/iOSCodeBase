//
//  ViewController.m
//  DVIRefresh
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 戴维营教育. All rights reserved.
//

#import "ViewController.h"

#import "UIView+DVIUtils.h"
#import "UIScrollView+DVIRefresh.h"

#import "DVIRefreshView.h"

@interface ViewController ()
{
    UIScrollView *_scrollView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIScrollView *scrollView1 = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView1.backgroundColor = [UIColor grayColor];
    scrollView1.contentSize = CGSizeMake(self.view.width, self.view.height * 2);
    [self.view addSubview:scrollView1];
        
    _scrollView = scrollView1;
    
    DVISimpleRefreshView *headerView = [DVISimpleRefreshView refreshViewWithPosition:DVIRefreshPositionHeader direction:DVIRefreshDirectionVertical block:^{
        NSLog(@"refresh triggered");
        
        [self performSelector:@selector(finished) withObject:nil afterDelay:3];
    }];
    headerView.backgroundColor = [UIColor redColor];
    scrollView1.headerView = headerView;
    
//    DVISimpleRefreshView *footerView = [DVISimpleRefreshView refreshViewWithPosition:DVIRefreshPositionFooter direction:DVIRefreshDirectionVertical block:^{
//        NSLog(@"load more triggered");
//        
//        [self performSelector:@selector(finished) withObject:nil afterDelay:3];
//    }];
//    footerView.backgroundColor = [UIColor greenColor];
//    scrollView1.footerView = footerView;
    
#if 0
    UIScrollView *scrollView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(110, 0, 200, 100)];
    scrollView2.backgroundColor = [UIColor grayColor];
    scrollView2.contentSize = CGSizeMake(300, 100);
    [self.view addSubview:scrollView2];
    
    DVISimpleRefreshView *headerView2 = [DVISimpleRefreshView refreshViewWithPosition:DVIRefreshPositionHeader direction:DVIRefreshDirectionHorizontal block:^{
        NSLog(@"horizontal refresh triggered");
    }];
    headerView2.backgroundColor = [UIColor redColor];
    scrollView2.headerView = headerView2;
    
    DVISimpleRefreshView *footerView2 = [DVISimpleRefreshView refreshViewWithPosition:DVIRefreshPositionFooter direction:DVIRefreshDirectionHorizontal block:^{
        NSLog(@"horizontal load more triggered");
    }];
    footerView2.backgroundColor = [UIColor greenColor];
    scrollView2.footerView = footerView2;
#endif
}

- (void)finished {
    [_scrollView endRefresh];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewCtrl = [sb instantiateViewControllerWithIdentifier:@"secondCtrl"];
    
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:viewCtrl];
    [self presentViewController:navCtrl animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
