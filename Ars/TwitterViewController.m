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
    NSString *domain;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    domain=@"http://7xlhe5.com1.z0.glb.clouddn.com";
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
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    UIImageView *imageV=(UIImageView*)[cell viewWithTag:1];
    if(imageV==nil){
        imageV = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, self.view.frame.size.width-20, 0)];
        imageV.tag=1;
        [cell addSubview:imageV];
    }
    UILabel *nameLabel =(UILabel*)[cell viewWithTag:2];
    if(nameLabel==nil){
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, self.view.frame.size.width-20, 22)];
        nameLabel.lineBreakMode=NSLineBreakByWordWrapping;
        nameLabel.numberOfLines=0;
        nameLabel.tag=2;
        nameLabel.textColor=[UIColor flatBlackColor];
        nameLabel.font = [UIFont fontWithName:@"Arial" size:15.0f];
        [cell addSubview:nameLabel];
    }

    TwitterBean  * bean = [list objectAtIndex:indexPath.row];
    if(bean){
        nameLabel.text =bean.content;
        CGSize size=[bean.content sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName]];
        CGFloat width = [UIScreen mainScreen].applicationFrame.size.width-50;
        CGFloat line = size.width/width;
        line = [self clcLine:line];
        CGFloat height =size.height*(line+1);
        nameLabel.frame=CGRectMake(8, 8, self.view.frame.size.width-20, height);
        if(bean.image){
            imageV.frame=CGRectMake(8, height+10, self.view.frame.size.width-20, 150);
            imageV.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",domain,bean.image]]]];
            imageV.hidden=NO;
        }else{
            imageV.hidden=YES;
        }
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   TwitterBean  * bean = [list objectAtIndex:indexPath.row];
    if(bean){
        CGSize size=[bean.content sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName]];
        CGFloat width = [UIScreen mainScreen].applicationFrame.size.width-50;
        CGFloat line = size.width/width;
        line = [self clcLine:line];
        CGFloat height =size.height*(line+1);
        if(bean.image){
            return height+170;
        }
        return height;
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
