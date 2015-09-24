//
//  FacebookViewController.m
//  Ars
//
//  Created by Shuwei on 15/9/24.
//  Copyright © 2015年 jov. All rights reserved.
//

#import "FacebookViewController.h"

@interface FacebookViewController ()

@end

@implementation FacebookViewController{
    NSMutableArray *list;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    list=[[NSMutableArray alloc] init];
    self.title=@"脸书上有堆堆";
    self.tableView.header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self load];
    }];
    [self.tableView.header beginRefreshing];
}
-(void)load{
    sleep(5);
    [self.tableView.header endRefreshing];
    [Common showMessageWithOkButton:@"加载失败了，请稍后再试"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
@end
