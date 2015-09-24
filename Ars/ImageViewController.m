//
//  ImageViewController.m
//  Ars
//
//  Created by Shuwei on 15/9/23.
//  Copyright © 2015年 jov. All rights reserved.
//

#import "ImageViewController.h"
#define MY_WIDTH [[UIScreen mainScreen] bounds].size.width
#define MY_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ImageViewController ()

@end

@implementation ImageViewController{
    int nextPage;
    NSMutableArray *imageArr;
    MBProgressHUD *hud;
}
@synthesize myScrollView = _myScrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"精美图片";
    self.myScrollView = [[MyScrollView alloc] initWithFrame:CGRectMake(0, 0, MY_WIDTH, MY_HEIGHT)];
    self.myScrollView.backgroundColor=FlatWhite;
    hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:hud];
    hud.labelText = @"加载中...";
    [hud show:YES];
    nextPage = 1;
    imageArr = [[NSMutableArray alloc] init];
    [MainService getImagesWithPageNo:nextPage andSuccess:^(NSMutableArray *result) {
        if(result&&[result count]>0){
            for(int i=0;i<[result count];i++){
                NSString *imageName = [result objectAtIndex:i];
                [self.myScrollView imageStartLoading:imageName];
            }
        }else{
            [Common showMessageWithOkButton:@"加载失败了，请稍后再试!"];
        }
        [hud hide:YES];
    } andError:^(NSInteger code) {
        [hud hide:YES];
        [Common showMessageWithOkButton:@"加载失败了，请稍后再试!"];
    }];
    _myScrollView.footer =  [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        nextPage++;
        [self startMyLoading];
    }];
    [self.view addSubview:_myScrollView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)startMyLoading{
    [MainService getImagesWithPageNo:(nextPage-1)*25 andSuccess:^(NSMutableArray *result) {
        if(result&&[result count]>0){
            for(int i=0;i<[result count];i++){
                NSString *imageName = [result objectAtIndex:i];
                [self.myScrollView imageStartLoading:imageName];
            }
        }
        [_myScrollView.footer endRefreshing];
    } andError:^(NSInteger code) {
        nextPage--;
        [_myScrollView.footer endRefreshing];
    }];
}
@end
