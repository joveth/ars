//
//  MoreDetailController.m
//  Ars
//
//  Created by Shuwei on 15/8/13.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "MoreDetailController.h"
#import "ShareData.h"

@interface MoreDetailController ()
@property (strong, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation MoreDetailController{
    UIButton *backBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =[ShareData shareInstance].title;
    backBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, self.view.frame.size.height-105, 40, 40)];
    backBtn.backgroundColor=[UIColor grayColor];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.hidden=YES;
    [self.view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backTo:) forControlEvents:UIControlEventTouchUpInside];
    [self showSV];
    self.webview.delegate = self;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    //[self loadData];
    [self.webview loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[ShareData shareInstance].url]]];
    // 添加下拉刷新控件http://m.dongqiudi.com/status.html?competition=139&type=trank#
    self.webview.scrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.webview reload];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)showSV{
    dispatch_async(dispatch_get_main_queue(),^ {
        [SVProgressHUD show];
    });
}
-(IBAction)backTo:(id)sender{
    if(self.webview.canGoBack){
        [self.webview goBack];
    }else{
        backBtn.hidden=YES;
    }
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    if(webView.canGoBack){
        backBtn.hidden=NO;
    }else{
        backBtn.hidden=YES;
    }
    [SVProgressHUD dismiss];
    [self.webview.scrollView.header endRefreshing ];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if(webView.canGoBack){
        backBtn.hidden=NO;
    }else{
        backBtn.hidden=YES;
    }
    [SVProgressHUD dismiss];
    [self.webview.scrollView.header endRefreshing ];
}
@end
