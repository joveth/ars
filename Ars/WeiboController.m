//
//  WeiboController.m
//  Ars
//
//  Created by Shuwei on 15/8/11.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "WeiboController.h"

@interface WeiboController ()

@end

@implementation WeiboController{
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
    //[self loadData];
    [webview loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://m.weibo.cn/d/OfficialArsenal?jumpfrom=weibocom"]]];
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
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{

    [SVProgressHUD dismiss];
    [webview.scrollView.header endRefreshing ];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
    [webview.scrollView.header endRefreshing ];
}

@end
