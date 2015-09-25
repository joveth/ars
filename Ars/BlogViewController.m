//
//  BlogViewController.m
//  Ars
//
//  Created by Shuwei on 15/9/25.
//  Copyright © 2015年 jov. All rights reserved.
//

#import "BlogViewController.h"

@interface BlogViewController ()

@end

@implementation BlogViewController{
    NSArray *list;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"对厄祖(不分好坏)的文章，要看看";
    
    BlogBean *bean1 = [[BlogBean alloc] init];
    bean1.title=@"针对厄齐尔的批评忽视了他低调的作用";
    bean1.url=@"article1";
    
    BlogBean *bean2 = [[BlogBean alloc] init];
    bean2.title=@"厄齐尔真的有问题";
    bean2.url=@"article2";
    
    BlogBean *bean3 = [[BlogBean alloc] init];
    bean3.title=@"一篇对厄齐尔的评价的文章";
    bean3.url=@"article3";
    BlogBean *bean4 = [[BlogBean alloc] init];
    bean4.title=@"谁也不该小瞧的梅苏特•厄齐尔";
    bean4.url=@"article4";
    list=[NSArray arrayWithObjects:bean1,bean2,bean4,bean3, nil];
    self.tableView.tableFooterView=[[UIView alloc] init];
    self.tableView.backgroundColor=[Common colorWithHexString:@"e0e0e0"];
    self.navigationItem.backBarButtonItem.tintColor=[UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellidentifier = @"cellIdentifier";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.tintColor = [UIColor greenColor];
    }
    BlogBean * bean = [list objectAtIndex:indexPath.row];
    if(bean){
        cell.textLabel.text =bean.title;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BlogBean * bean = [list objectAtIndex:indexPath.row];
    if(bean){
        [ShareData shareInstance].title=bean.title;
        [ShareData shareInstance].flag=NO;
        [ShareData shareInstance].url=bean.url;
        WebViewController *show = [[WebViewController alloc] init];
        [self.navigationController pushViewController:show animated:YES];
    }
}
@end
