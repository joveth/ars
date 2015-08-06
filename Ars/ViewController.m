//
//  ViewController.m
//  Ars
//
//  Created by Shuwei on 15/8/6.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController{
    UIWebView *webview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    webview = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [self showSV];
    [self.view addSubview:webview];
    webview.delegate = self;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [webview loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://tieba.baidu.com/f?kw=%E9%98%BF%E6%A3%AE%E7%BA%B3"]]];
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
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"加载失败了"];
}

@end
