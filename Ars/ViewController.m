//
//  ViewController.m
//  Ars
//
//  Created by Shuwei on 15/8/6.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"
#import "NetCall.h"
#import "Common.h"
@interface ViewController ()

@end

@implementation ViewController{
    UIWebView *webview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.tintColor = [Common colorWithHexString:@"eb4f38"];
    [self.tabBarController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"iconfont_tie"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
    [[[self.tabBarController.viewControllers objectAtIndex:0] tabBarItem] setSelectedImage:[UIImage imageNamed:@"iconfont_tie"]];
    [[[self.tabBarController.viewControllers objectAtIndex:1] tabBarItem] setSelectedImage:[UIImage imageNamed:@"iconfont_sina"]];
    [[[self.tabBarController.viewControllers objectAtIndex:2] tabBarItem] setSelectedImage:[UIImage imageNamed:@"iconfont_score"]];
    [[[self.tabBarController.viewControllers objectAtIndex:3] tabBarItem] setSelectedImage:[UIImage imageNamed:@"iconfont_weibo"]];
    [[[self.tabBarController.viewControllers objectAtIndex:4] tabBarItem] setSelectedImage:[UIImage imageNamed:@"iconfont_more"]];
    CGRect frame = self.view.frame;
    frame.size.height-=50;
    webview = [[UIWebView alloc] initWithFrame:frame];
    [self showSV];
    [self.view addSubview:webview];
    webview.delegate = self;
//    [NetCall queryTieWithPageNo:1 andCallBack:^(NSMutableArray *_ret) {
//        
//    }];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [webview loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://tieba.baidu.com/f?kw=%E9%98%BF%E6%A3%AE%E7%BA%B3"]]];
    // 添加下拉刷新控件
    webview.scrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [webview reload];
    }];
}
-(void)showSV{
    dispatch_async(dispatch_get_main_queue(),^ {
        [SVProgressHUD show];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    
    [webview.scrollView.header endRefreshing ];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"加载失败了"];
    [webview.scrollView.header endRefreshing ];
}

@end
