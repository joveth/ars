//
//  ScoreController.m
//  Ars
//
//  Created by Shuwei on 15/8/10.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "ScoreController.h"
#import "NetCall.h"

@interface ScoreController ()

@end

@implementation ScoreController{
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
    [webview loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://m.dongqiudi.com/status.html?competition=139&type=trank#"]]];
    // 添加下拉刷新控件http://m.dongqiudi.com/status.html?competition=139&type=trank#
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
    [webView stringByEvaluatingJavaScriptFromString:@"var tagHead =document.getElementById(\"top\");"
     "tagHead.parentNode.removeChild(tagHead);"
     "var temp = document.getElementById(\"header-yuedong\");"
     "temp.parentNode.removeChild(temp);"];
    [SVProgressHUD dismiss];
    [webview.scrollView.header endRefreshing ];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"加载失败了"];
    [webview.scrollView.header endRefreshing ];
}

@end
