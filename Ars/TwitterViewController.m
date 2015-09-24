//
//  TwitterViewController.m
//  Ars
//
//  Created by Shuwei on 15/9/24.
//  Copyright © 2015年 jov. All rights reserved.
//

#import "TwitterViewController.h"

@interface TwitterViewController ()

@end

@implementation TwitterViewController{
    NSMutableArray *list;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    list=[[NSMutableArray alloc] init];
    self.title=@"齐齐在推特上";
    self.tableView.header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self load];
    }];
    [self.tableView.header beginRefreshing];
}
-(void)load{
    [MainService getTwitter:0 andSuccess:^(NSMutableArray *result) {
        [self.tableView.header endRefreshing];
        if(result&&[result count]>0){
            [list removeAllObjects];
            [list addObjectsFromArray:result];
            [self.tableView reloadData];
        }else{
            [Common showMessageWithOkButton:@"加载失败了，请稍后再试"];
        }
    } andError:^(NSInteger code) {
        [self.tableView.header endRefreshing];
        [Common showMessageWithOkButton:@"加载失败了，请稍后再试"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

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
    NSString  * content = [list objectAtIndex:indexPath.row];
    if(content){
        cell.textLabel.text =content;
        cell.textLabel.textColor=[UIColor flatBlackColor];
        cell.textLabel.numberOfLines=0;
        cell.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
        CGSize size=[content sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName]];
        CGFloat width = [UIScreen mainScreen].applicationFrame.size.width-50;
        CGFloat line = size.width/width;
        line = [self clcLine:line];
        CGFloat height =size.height*(line+1);
        cell.textLabel.frame=CGRectMake(8, 8, self.view.frame.size.width-20, height+44);
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString  * content = [list objectAtIndex:indexPath.row];
    if(content){
        CGSize size=[content sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName]];
        CGFloat width = [UIScreen mainScreen].applicationFrame.size.width-50;
        CGFloat line = size.width/width;
        line = [self clcLine:line];
        CGFloat height =size.height*(line+1);
        
        return height+44;
    }
    return 44;
}

-(CGFloat)clcLine:(CGFloat)width{
    if(width<1){
        width=1;
    }else{
        NSString *th = [NSString stringWithFormat:@"%0.0f",width];
        NSInteger t = th.integerValue;
        if(width-t>0){
            width  = t+1;
        }else{
            width = t;
        }
    }
    return width;
}
@end
