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
    UIButton *backBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = self.view.frame;
    frame.size.height-=50;
    webview = [[UIWebView alloc] initWithFrame:frame];
    backBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, frame.size.height-55, 40, 40)];
    backBtn.backgroundColor=[UIColor grayColor];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self showSV];
    [self.view addSubview:webview];
    [self.view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backTo:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.hidden=YES;
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
-(IBAction)backTo:(id)sender{
    if(webview.canGoBack){
        [webview goBack];
    }else{
        backBtn.hidden=YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    if(webView.canGoBack){
        backBtn.hidden=NO;
    }else{
        backBtn.hidden=YES;
    }
    [webview.scrollView.header endRefreshing ];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
    if(webView.canGoBack){
        backBtn.hidden=NO;
    }else{
        backBtn.hidden=YES;
    }
    [webview.scrollView.header endRefreshing ];
}

@end
