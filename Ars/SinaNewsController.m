//
//  SinaNewsController.m
//  Ars
//
//  Created by Shuwei on 15/8/7.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "SinaNewsController.h"

@interface SinaNewsController ()

@end

@implementation SinaNewsController{
    UIWebView *webview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = self.view.frame;
    frame.size.height-=50;
    webview = [[UIWebView alloc] initWithFrame:frame];
    [self showSV];
    [self.view addSubview:webview];
    webview.delegate = self;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [webview loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://sports.sina.cn/?sa=t31d43v17&from=wap"]]];
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
