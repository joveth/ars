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
    //[self loadData];
    [webview loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://m.hupu.com/soccer/england/rank/score"]]];
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
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    [webView stringByEvaluatingJavaScriptFromString:@"var tagHead =document.getElementById(\"top\");"
//     "tagHead.parentNode.removeChild(tagHead);"
//     "var temp = document.getElementById(\"header-yuedong\");"
//     "temp.parentNode.removeChild(temp);"
//     "temp = document.getElementById(\"fade\");"
//     "temp.parentNode.removeChild(temp);"
//     "temp = document.getElementsByClassName(\"popup\")[0];temp.parentNode.removeChild(temp); "];
    if(webView.canGoBack){
        backBtn.hidden=NO;
    }else{
        backBtn.hidden=YES;
    }
    
    [SVProgressHUD dismiss];
    
    [webview.scrollView.header endRefreshing ];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    [webView stringByEvaluatingJavaScriptFromString:@"var tagHead =document.getElementById(\"top\");"
//     "tagHead.parentNode.removeChild(tagHead);"
//     "var temp = document.getElementById(\"header-yuedong\");"
//     "temp.parentNode.removeChild(temp);"];
    if(webView.canGoBack){
        backBtn.hidden=NO;
    }else{
        backBtn.hidden=YES;
    }
    [SVProgressHUD dismiss];
    [webview.scrollView.header endRefreshing ];
}

@end
