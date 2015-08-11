//
//  MoreController.m
//  Ars
//
//  Created by Shuwei on 15/8/11.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "MoreController.h"
#import "Common.h"

@interface MoreController ()

@end

@implementation MoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=[Common colorWithHexString:@"#e0e0e0"];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *myHeader = [[UIView alloc] init];
    UILabel *myLabel = [[UILabel alloc] init];
    [myLabel setFrame:CGRectMake(8, 0, 200, 10)];
    [myLabel setTag:101];
    [myLabel setAlpha:0.5];
    [myLabel setFont: [UIFont fontWithName:@"Arial" size:14]];
    [myLabel setBackgroundColor:[UIColor clearColor]];
    [myHeader setBackgroundColor:[Common colorWithHexString:@"#e0e0e0"]];
    [myLabel setText:[NSString stringWithFormat:@" "]];
    [myHeader addSubview:myLabel];
    
    return myHeader;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (IBAction)toMoreMng:(UIStoryboardSegue *)segue
{
    [[segue sourceViewController] class];
}
@end
