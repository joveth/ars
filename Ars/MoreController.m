//
//  MoreController.m
//  Ars
//
//  Created by Shuwei on 15/8/11.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "MoreController.h"
#import "Common.h"
#import "ShareData.h"

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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [ShareData shareInstance].flag=NO;
    if(indexPath.section==0){
        if(indexPath.row==0){
            [ShareData shareInstance].title=@"阿森纳官方中文网站";
            [ShareData shareInstance].url=@"http://cn.arsenal.com/";
        }else if(indexPath.row==1){
            [ShareData shareInstance].title=@"虎扑阿森纳专区";
            [ShareData shareInstance].url=@"http://m.hupu.com/bbs/2918";
        }else if(indexPath.row==2){
            [ShareData shareInstance].title=@"百度百科阿森纳";
            [ShareData shareInstance].url=@"http://wapbaike.baidu.com/view/3447712.htm?adapt=1&fr=aladdin&fromid=15280976&fromtitle=%E9%98%BF%E6%A3%AE%E7%BA%B3&type=syn";
        }
        [self performSegueWithIdentifier:@"toDetail" sender:self];
    }else if(indexPath.section==1){
        if(indexPath.row==0){
            [self performSegueWithIdentifier:@"toUser" sender:self];
        }else{
            [ShareData shareInstance].title=@"未来计划.eg";
            [ShareData shareInstance].url=@"http://joveth.github.io/ars/index.html";
            [self performSegueWithIdentifier:@"toDetail" sender:self];
        }
    }
    
}
- (IBAction)toMoreMng:(UIStoryboardSegue *)segue
{
    [[segue sourceViewController] class];
}
@end
